SELECT a.segment1,
       a.name 

,
       A.PROJECT_ID,
       A.Project_Type,
       B.PROJ_ELEMENT_ID task_id,
       C.element_version_id,
       B.ELEMENT_NUMBER task_number,
       B.NAME 

 task_name,
       
       b.CHARGEABLE_FLAG,
       c.FINANCIAL_TASK_FLAG,
/*       (SELECT ppe_phase.phase_code
          FROM apps.pa_proj_element_versions ppev_phase, apps.pa_proj_elements ppe_phase
         WHERE ppev_phase.element_version_id = b.phase_version_id
           AND ppe_phase.proj_element_id = ppev_phase.proj_element_id) phase_code,
       (SELECT pps.project_status_name
          FROM apps.pa_proj_element_versions ppev_phase,
               apps.pa_proj_elements         ppe_phase,
               apps.pa_project_statuses      pps
         WHERE ppev_phase.element_version_id = b.phase_version_id
           AND ppe_phase.proj_element_id = ppev_phase.proj_element_id
           AND ppe_phase.phase_code = pps.PROJECT_STATUS_CODE) phase_name,*/
       d.ATTRIBUTE1 任务类别,
       --d.ATTRIBUTE2 "子项/合同包/标段编码",
       (SELECT ptt.task_type FROM pa.pa_task_types ptt WHERE ptt.task_type_id = b.type_id) task_type,
       b.BASE_PERCENT_COMP_DERIV_CODE,
       c.financial_task_flag,
       
       b.*
  FROM apps.PA_PROJECTS_ALL            A,
       apps.PA_PROJ_ELEMENTS           B,
       apps.PA_PROJ_ELEMENT_VERSIONS   C,
       apps.pa_proj_elem_ver_schedule  D,
       apps.PA_PROJ_ELEM_VER_STRUCTURE STC
 WHERE A.PROJECT_ID = B.PROJECT_ID
   AND B.PROJECT_ID = C.PROJECT_ID
   AND B.PROJ_ELEMENT_ID = C.PROJ_ELEMENT_ID
   AND B.OBJECT_TYPE = 'PA_TASKS'
   AND C.project_id = D.project_id(+)
   AND C.element_version_id = D.element_version_id(+)
   AND C.PARENT_STRUCTURE_VERSION_ID = stc.element_version_id
      --AND c.financial_task_flag = 'N'
   AND STC.STATUS_CODE = 'STRUCTURE_WORKING'
      --AND c.wbs_level = 1 --只查顶层任务
   AND a.segment1 LIKE '867%'
   --AND b.ELEMENT_NUMBER IN ('6.1','7.1','7.2')
   --AND B.CREATION_DATE > to_date('2017-5-25 18:45:00','yyyy-mm-dd hh24:mi:ss')
 ORDER BY b.PROJECT_ID,c.display_sequence;
