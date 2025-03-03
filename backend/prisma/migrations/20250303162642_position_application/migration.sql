/*
  Warnings:

  - Added the required column `updated_at` to the `Candidate` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Candidate" ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL;

-- CreateTable
CREATE TABLE "Company" (
    "company_id" SERIAL NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "company_description" TEXT,

    CONSTRAINT "Company_pkey" PRIMARY KEY ("company_id")
);

-- CreateTable
CREATE TABLE "Employee" (
    "employee_id" SERIAL NOT NULL,
    "company_id" INTEGER NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "role" VARCHAR(100) NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "Employee_pkey" PRIMARY KEY ("employee_id")
);

-- CreateTable
CREATE TABLE "PositionStatus" (
    "position_status_id" SERIAL NOT NULL,
    "status_name" VARCHAR(100) NOT NULL,

    CONSTRAINT "PositionStatus_pkey" PRIMARY KEY ("position_status_id")
);

-- CreateTable
CREATE TABLE "EmploymentType" (
    "employment_type_id" SERIAL NOT NULL,
    "type_name" VARCHAR(100) NOT NULL,

    CONSTRAINT "EmploymentType_pkey" PRIMARY KEY ("employment_type_id")
);

-- CreateTable
CREATE TABLE "InterviewFlow" (
    "interview_flow_id" SERIAL NOT NULL,
    "description" VARCHAR(255) NOT NULL,

    CONSTRAINT "InterviewFlow_pkey" PRIMARY KEY ("interview_flow_id")
);

-- CreateTable
CREATE TABLE "InterviewType" (
    "interview_type_id" SERIAL NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "description" TEXT,

    CONSTRAINT "InterviewType_pkey" PRIMARY KEY ("interview_type_id")
);

-- CreateTable
CREATE TABLE "InterviewStep" (
    "interview_step_id" SERIAL NOT NULL,
    "interview_flow_id" INTEGER NOT NULL,
    "interview_type_id" INTEGER NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "order_index" INTEGER NOT NULL,

    CONSTRAINT "InterviewStep_pkey" PRIMARY KEY ("interview_step_id")
);

-- CreateTable
CREATE TABLE "Position" (
    "position_id" SERIAL NOT NULL,
    "company_id" INTEGER NOT NULL,
    "interview_flow_id" INTEGER NOT NULL,
    "position_status_id" INTEGER NOT NULL,
    "employment_type_id" INTEGER NOT NULL,
    "title" VARCHAR(100) NOT NULL,
    "description" TEXT,
    "is_visible" BOOLEAN NOT NULL DEFAULT true,
    "location" VARCHAR(100) NOT NULL,
    "job_description" TEXT,
    "requirements" TEXT,
    "responsibilities" TEXT,
    "salary_min" DECIMAL(10,2),
    "salary_max" DECIMAL(10,2),
    "benefits" TEXT,
    "application_deadline" TIMESTAMP(3),
    "contact_info" VARCHAR(255),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Position_pkey" PRIMARY KEY ("position_id")
);

-- CreateTable
CREATE TABLE "ApplicationStatus" (
    "application_status_id" SERIAL NOT NULL,
    "status_name" VARCHAR(100) NOT NULL,

    CONSTRAINT "ApplicationStatus_pkey" PRIMARY KEY ("application_status_id")
);

-- CreateTable
CREATE TABLE "Application" (
    "application_id" SERIAL NOT NULL,
    "position_id" INTEGER NOT NULL,
    "candidate_id" INTEGER NOT NULL,
    "application_status_id" INTEGER NOT NULL,
    "application_date" TIMESTAMP(3) NOT NULL,
    "notes" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Application_pkey" PRIMARY KEY ("application_id")
);

-- CreateTable
CREATE TABLE "InterviewResult" (
    "interview_result_id" SERIAL NOT NULL,
    "result_name" VARCHAR(100) NOT NULL,

    CONSTRAINT "InterviewResult_pkey" PRIMARY KEY ("interview_result_id")
);

-- CreateTable
CREATE TABLE "Interview" (
    "interview_id" SERIAL NOT NULL,
    "application_id" INTEGER NOT NULL,
    "interview_step_id" INTEGER NOT NULL,
    "employee_id" INTEGER NOT NULL,
    "interview_result_id" INTEGER,
    "interview_date" TIMESTAMP(3) NOT NULL,
    "score" INTEGER,
    "notes" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Interview_pkey" PRIMARY KEY ("interview_id")
);

-- CreateIndex
CREATE INDEX "Company_name_idx" ON "Company"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Employee_email_key" ON "Employee"("email");

-- CreateIndex
CREATE INDEX "Employee_email_idx" ON "Employee"("email");

-- CreateIndex
CREATE INDEX "Employee_company_id_is_active_idx" ON "Employee"("company_id", "is_active");

-- CreateIndex
CREATE INDEX "PositionStatus_status_name_idx" ON "PositionStatus"("status_name");

-- CreateIndex
CREATE INDEX "EmploymentType_type_name_idx" ON "EmploymentType"("type_name");

-- CreateIndex
CREATE INDEX "InterviewFlow_description_idx" ON "InterviewFlow"("description");

-- CreateIndex
CREATE INDEX "InterviewType_name_idx" ON "InterviewType"("name");

-- CreateIndex
CREATE INDEX "InterviewStep_interview_flow_id_order_index_idx" ON "InterviewStep"("interview_flow_id", "order_index");

-- CreateIndex
CREATE INDEX "Position_title_location_is_visible_idx" ON "Position"("title", "location", "is_visible");

-- CreateIndex
CREATE INDEX "Position_application_deadline_idx" ON "Position"("application_deadline");

-- CreateIndex
CREATE INDEX "Position_position_status_id_idx" ON "Position"("position_status_id");

-- CreateIndex
CREATE INDEX "Position_employment_type_id_idx" ON "Position"("employment_type_id");

-- CreateIndex
CREATE INDEX "Position_company_id_idx" ON "Position"("company_id");

-- CreateIndex
CREATE INDEX "ApplicationStatus_status_name_idx" ON "ApplicationStatus"("status_name");

-- CreateIndex
CREATE INDEX "Application_position_id_idx" ON "Application"("position_id");

-- CreateIndex
CREATE INDEX "Application_candidate_id_idx" ON "Application"("candidate_id");

-- CreateIndex
CREATE INDEX "Application_application_status_id_idx" ON "Application"("application_status_id");

-- CreateIndex
CREATE INDEX "Application_application_date_idx" ON "Application"("application_date");

-- CreateIndex
CREATE INDEX "Application_created_at_idx" ON "Application"("created_at");

-- CreateIndex
CREATE INDEX "InterviewResult_result_name_idx" ON "InterviewResult"("result_name");

-- CreateIndex
CREATE INDEX "Interview_application_id_idx" ON "Interview"("application_id");

-- CreateIndex
CREATE INDEX "Interview_interview_step_id_idx" ON "Interview"("interview_step_id");

-- CreateIndex
CREATE INDEX "Interview_employee_id_idx" ON "Interview"("employee_id");

-- CreateIndex
CREATE INDEX "Interview_interview_date_idx" ON "Interview"("interview_date");

-- CreateIndex
CREATE INDEX "Interview_created_at_idx" ON "Interview"("created_at");

-- CreateIndex
CREATE INDEX "Candidate_firstName_lastName_email_idx" ON "Candidate"("firstName", "lastName", "email");

-- CreateIndex
CREATE INDEX "Candidate_created_at_idx" ON "Candidate"("created_at");

-- AddForeignKey
ALTER TABLE "Employee" ADD CONSTRAINT "Employee_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "Company"("company_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InterviewStep" ADD CONSTRAINT "InterviewStep_interview_flow_id_fkey" FOREIGN KEY ("interview_flow_id") REFERENCES "InterviewFlow"("interview_flow_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InterviewStep" ADD CONSTRAINT "InterviewStep_interview_type_id_fkey" FOREIGN KEY ("interview_type_id") REFERENCES "InterviewType"("interview_type_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Position" ADD CONSTRAINT "Position_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "Company"("company_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Position" ADD CONSTRAINT "Position_interview_flow_id_fkey" FOREIGN KEY ("interview_flow_id") REFERENCES "InterviewFlow"("interview_flow_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Position" ADD CONSTRAINT "Position_position_status_id_fkey" FOREIGN KEY ("position_status_id") REFERENCES "PositionStatus"("position_status_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Position" ADD CONSTRAINT "Position_employment_type_id_fkey" FOREIGN KEY ("employment_type_id") REFERENCES "EmploymentType"("employment_type_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_position_id_fkey" FOREIGN KEY ("position_id") REFERENCES "Position"("position_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_candidate_id_fkey" FOREIGN KEY ("candidate_id") REFERENCES "Candidate"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_application_status_id_fkey" FOREIGN KEY ("application_status_id") REFERENCES "ApplicationStatus"("application_status_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Interview" ADD CONSTRAINT "Interview_application_id_fkey" FOREIGN KEY ("application_id") REFERENCES "Application"("application_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Interview" ADD CONSTRAINT "Interview_interview_step_id_fkey" FOREIGN KEY ("interview_step_id") REFERENCES "InterviewStep"("interview_step_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Interview" ADD CONSTRAINT "Interview_employee_id_fkey" FOREIGN KEY ("employee_id") REFERENCES "Employee"("employee_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Interview" ADD CONSTRAINT "Interview_interview_result_id_fkey" FOREIGN KEY ("interview_result_id") REFERENCES "InterviewResult"("interview_result_id") ON DELETE SET NULL ON UPDATE CASCADE;
