SELECT DISTINCT papf.PERSON_ID,
                papf.EMPLOYEE_NUMBER,
                papf.FULL_NAME,
                ppa.SEGMENT1,
                ppe.ELEMENT_NUMBER,
                ppe.NAME

  FROM apps.cux_pa_dlv_schedule_spec_t dss,
       apps.per_all_assignments_f      paaf,
       apps.per_all_assignments_f      paaf1,
       apps.per_grades                 pg,
       apps.per_all_people_f           papf,
       apps.pa_projects_all            ppa,
       apps.pa_proj_elements           ppe
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
   and ppa.SEGMENT1 = '888'
   and ppe.ELEMENT_NUMBER = '9.43'
