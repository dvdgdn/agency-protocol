-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "public";

-- CreateTable
CREATE TABLE "public"."cas_store" (
    "cid" TEXT NOT NULL,
    "mime_type" TEXT NOT NULL DEFAULT 'application/octet-stream',
    "data" BYTEA NOT NULL,
    "created_at" TIMESTAMPTZ(6) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "cas_store_pkey" PRIMARY KEY ("cid")
);

