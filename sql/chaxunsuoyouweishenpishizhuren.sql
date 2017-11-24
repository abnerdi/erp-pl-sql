alter session set current_schema = apps;
with aa as
 (select pds.PROJECT_ID, pds.TASK_ID, aaa.EMP_ID, wf_core.activity_result('AME_STATUS', aaa.action_code) action
    from cux_pa_dlv_schedule_t pds, cux_ame_approve_actions aaa
   where pds.ATTRIBUTE1 = aaa.TRANSACTION_ID
     and aaa.TRANSACTION_TYPE = 'CUXPADSDAPPRV')
SELECT DISTINCT papf.PERSON_ID,
                papf.EMPLOYEE_NUMBER,
                papf.FULL_NAME,
                ppa.SEGMENT1,
                ppe.ELEMENT_NUMBER,
                ppe.NAME,
                aa.action
  FROM apps.cux_pa_dlv_schedule_spec_t dss,
       apps.per_all_assignments_f      paaf,
       apps.per_all_assignments_f      paaf1,
       apps.per_grades                 pg,
       apps.per_all_people_f           papf,
       apps.pa_projects_all            ppa,
       apps.pa_proj_elements           ppe,
       aa
 WHERE dss.specialty_manager = paaf.person_id
   AND trunc(SYSDATE) BETWEEN
       trunc(nvl(paaf.effective_start_date, SYSDATE - 1)) AND
       trunc(nvl(paaf.effective_end_date, SYSDATE + 1))
   AND trunc(SYSDATE) BETWEEN
       trunc(nvl(papf.effective_start_date, SYSDATE - 1)) AND
       trunc(nvl(papf.effective_end_date, SYSDATE + 1))
   AND paaf.primary_flag = 'Y'
   and paaf1.PERSON_ID = papf.PERSON_ID
   AND trunc(SYSDATE) BETWEEN
       trunc(nvl(paaf1.effective_start_date, SYSDATE - 1)) AND
       trunc(nvl(paaf1.effective_end_date, SYSDATE + 1))
   AND paaf1.organization_id = paaf.organization_id
   AND paaf1.grade_id = pg.grade_id
   AND pg.name 

 in ('室主任', '室副主任')
   and dss.PROJECT_ID = ppa.PROJECT_ID
   and dss.TASK_ID = ppe.PROJ_ELEMENT_ID
   and dss.PROJECT_ID = aa.project_id
   and dss.task_id = aa.task_id
   and papf.PERSON_ID = aa.emp_id
   and ppa.SEGMENT1 = 'Z1488'
   and ppe.ELEMENT_NUMBER = '8.2'
