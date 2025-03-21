-- Table: public.messages

CREATE TABLE IF NOT EXISTS public.messages
(
    id integer NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
    conversation_id uuid NOT NULL,
    model text COLLATE pg_catalog."default" NOT NULL,
    prompt text COLLATE pg_catalog."default" NOT NULL,
    response text COLLATE pg_catalog."default" NOT NULL,
    created_at timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT messages_pkey PRIMARY KEY (id),
    CONSTRAINT messages_conversation_id_fkey FOREIGN KEY (conversation_id)
        REFERENCES public.user_conversations (conversation_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.messages
    OWNER to "teaching-assistant";

COMMENT ON TABLE public.messages
    IS 'Message tuples of a conversation grouped by conversation_id';

COMMENT ON COLUMN public.messages.id
    IS 'Provides a mechanism for sorting message tuples of a conversation';

COMMENT ON COLUMN public.messages.conversation_id
    IS 'GUID set by the application that identifies a group of messages';

COMMENT ON COLUMN public.messages.prompt
    IS 'A user prompt message from a conversation';

COMMENT ON COLUMN public.messages.response
    IS 'An assistant response message from a conversation';

-- Index: fki_messages_conversation_id_fkey

CREATE INDEX IF NOT EXISTS fki_messages_conversation_id_fkey
    ON public.messages USING btree
    (conversation_id ASC NULLS LAST)
    TABLESPACE pg_default;