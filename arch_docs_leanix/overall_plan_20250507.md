# Project

### Goals
- Move Customer and ProductMaterial models over to Aurora.
- Get usk below the 700k contract limit by 31-May-2025.

### week 1
- [SCOTT] Aurora: build the PROD models out.
- [TODO] Data: Discuss plan to populate and syncronize REPOs.
- [QUINN] DB: Manual build of the ProductMaterial DB Model with DataAPI.
- [STARTED] INTs: assignments made and work started on Ports.
- [STARTED] INTs: Port Integrations to push/pull data from Aurora.

### week 2
- Data: populate and continuosly syncronize REPOs.
- INTs: Review the ported integrations with another team member.
- INTs: PREP deploy and update/pull data into the TEDE environment.

### week 3.1
- Data & INTs: Deploy to PREP and update/pull data into the TEDE environment.
- PREP: Hypercare: validate data movements are identical to PROD.

### week 3.2
- Data: populate and continuosly syncronize REPOs.
- INTs: Deploy to PROD and switch integrations to use Aurora.
- PROD: Hypercare along with active data movement reviews.

### week 4
- Go/NoGo for the removal of the legacy models.
- Remove the 2 models in the PROD/TEST/DEVL REPOs.

#### Additional Shorterm TODOs
- Build out GraphQL to support all Posts and Gets.
- Build out Boomi subprocess call requirements.
  + Post API: populate Customer and ProductMaterial.
  + Get API: gets for Customer and ProductMaterial requirements.
  + hardcoded API Keys in boomi PP for now (max: 365).
- Boomi Get: Boomi get API with hardcoded API Keys (Customer, ProductMaterial).

#### Additional Longterm TODOs
- Store the GraphQL API and AppSync keys in the AWS Secrets Manager.
- Best Practice Lambda to auto-rotated and auto-updated keys in Secrets Manager.
- Best practice to buildout an APP API for boomi to call for latest active keys.
- Document backup and restore policy and procedures. Recover back to a particular date.


# Action Items

### INTs
- Customer
  + [NICK] Upstream: SapCustomerMasterPROC_QUE>MDH
  + []  Downstream: CustomerMasterSales_MdhAPI>SfAPI
  + [QUINN] Downstream: SapCustomerMasterScheduler_MdhAPI>TiberSFTP
- ProductMaterial
  + [SCOTT] Upstream: SapMaterialMasterPROC_QUE>MDH
  + [] Downstream: ProductMasterData_MdhAPI>SfAPI
  + [] Downstream: SapProductMasterScheduler_MdhAPI>TiberSFTP

### Previous
[DONE] – Manual building of the Customer DB Model Structure using the DataAPI.
  + each reapeating group is a separate table.
  + 1 hour to manually build - RPA/AI would help.
[NIK] – Setup a prototype of the data api into the provisioned prototype Aurora PostgreSQL DB.
  + write 100 existing records using the DataAPI
[QUINN] – Configure and setup the GraphQL interface.

# Information

### Models
- Customer
  + objt: customer
  + srcs: CustomerCon (REPO:Contribute)
  + tags: TibersoftCustomerOutbound
  + univ: 2096af64-83e6-4ccc-81dd-73f16342e0a2
  + PROD: 134,981
- ProductMaterial
  + objt: productmaterial
  + srcs: ProductMaterialCon (MODEL:both)
  + tags: TibersoftProductOutbound
  + tags: SalesforceProductMaterialOutbound
  + tags: ProductMasterOutbound
  + tags: ProductMaterialToProduct
  + univ: b47fa65a-aaf4-4622-bea3-8f75c95c24d6
  + PROD: 217,973

### Questions
- how long did the import take for 100 records
- boomi integration development timelines
- record size limitation

## Model Investigation

### PRODC - Integration review (MDH >)
- ProductHierarchyOutboundREDWD_MdhAPI>SfREST 4.0.0
  + 5d2e92e5-b58d-4b5b-9433-871f00e33581
- UserDataIntegration_MdhWS>AribaWS 4.0.0
  + cf4f004f-27d0-4b44-8e10-63da599396c3
- ProductMasterData_MdhAPI>SfAPI 4.0.0
  + b47fa65a-aaf4-4622-bea3-8f75c95c24d6
  + 5d2e92e5-b58d-4b5b-9433-871f00e33581
- CustomerMasterSales_MdhAPI>SfAPI 4.0.0
  + 2096af64-83e6-4ccc-81dd-73f16342e0a2
  + a7ec56ef-7035-4397-a7b3-18ac5cc3a513
  + 5b9e0a4b-ad84-4223-8e37-3c4eb2d186dd
- ChTimestampREDWD_MdhAPI>SfAPI 4.0.0
  + 5b9e0a4b-ad84-4223-8e37-3c4eb2d186dd
- SapProductMasterScheduler_MdhAPI>TiberSFTP 4.0.0
  + b47fa65a-aaf4-4622-bea3-8f75c95c24d6

### PRODB - Integration review (MDH >)
- none with an MDH source in the name

### PRODA - Integration review (MDH >)
-
