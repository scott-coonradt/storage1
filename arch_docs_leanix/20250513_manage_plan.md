# Project

### Goals
- Move **Customer** and **ProductMaterial** models over to Aurora.
- Get us below the 700k contract limit by 31-May-2025.

### week 0 (Week 28-Apr)
- [DONE] Aurora: build out a prototype model.
- [DONE] DB: Manual build of the **Customer** DB Model with DataAPI.
- [DONE] INTs: initial assignments made and work started on Ports.

### week 1 (Week 05-May)
- [DONE] Aurora: build the TEDE models out.
- [DONE] Setup and build GraphQL to support Gets.
- [NIK] Setup a data api load (100 records) into the provisioned prototype DB.
- [QUINN] DB: Manual build of the **ProductMaterial** DB Model with DataAPI.
- [NIK] Upstream: SapCustomerMasterPROC_QUE>MDH
- [QUINN] Downstream: SapCustomerMasterScheduler_MdhAPI>TiberSFTP
- [SCOTT] Upstream: SapMaterialMasterPROC_QUE>MDH

### Week 0 & 1 Challenges
- Cutover to suppor this effort has been slow as we continue to get pulled into other things.
- Additonal resource needed to help populate TEDE and PROD Aurora Models.

### week 2 (Week 12-May)
- [TBD] Data: Populate and syncronize to TEDE models.
- [SCOTT] Aurora: build the PROD models out.
- [SCOTT] Work with engineer to get data populated in TEDE.
- [QUINN]  build GraphQL gets for **Customer** and **ProductMaterial**.
- [QUINN] Use GraphQL: Downstream: ProductMasterData_MdhAPI>SfAPI
- [QUINN] Use GraphQL: Downstream: SapProductMasterScheduler_MdhAPI>TiberSFTP
- [NIK]  Use GraphQL: Downstream: CustomerMasterSales_MdhAPI>SfAPI
- [ALL] INTs: Review and deploy to the TESTB environment.

### week 3 (Week 19-May)
- [TBD] Data: Populate and syncronize to PROD models.
- [ALL] INTs: Deploy to PRODB and dry run pulling data from the PROD models.
- [ALL] validate data movements are identical to PROD.

### week 4 (Week 26-May)
- [ALL] INTs: Deploy to PROD and switch integrations to use Aurora.
- [ALL] Go/NoGo for the removal of the legacy models.
- [TBD] Remove the 2 legacy models in the BOOMI REPOs.

