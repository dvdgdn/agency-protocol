-- CreateTable
CREATE TABLE "public"."Merit" (
    "id" TEXT NOT NULL,
    "agentId" TEXT NOT NULL,
    "meritScore" INTEGER NOT NULL,
    "lastUpdated" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Merit_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Merit_agentId_key" ON "public"."Merit"("agentId");
