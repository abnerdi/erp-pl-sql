select *
  from apps.PA_PROJ_ELEM_VER_STRUCTURE stc,--����PEV_STRUCTURE_ID�ֶ���Ҫָ��wbs�ṹ��ID
       apps.PA_PROJ_ELEMENT_VERSIONS            A

    where 
       
       A.PARENT_STRUCTURE_VERSION_ID = stc.element_version_id --1�׶�:��ȡ��ǰ��Ŀ���µ�wbs�ṹ
       and stc.STATUS_CODE = 'STRUCTURE_WORKING'   --1�׶�
       and A.OBJECT_TYPE='PA_TASKS'  --��ȡ����ṹ
       and A.PROJECT_ID=3391   --1�׶�
       
         order by A.DISPLAY_SEQUENCE  --Ȼ����Ŀ����wbs�ṹ����ʵ˳���������
