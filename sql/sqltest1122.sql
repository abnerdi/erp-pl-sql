
select * from apps.PA_PROJECTS_ALL D;

select * from apps.CUX_PA_DLV_SCHEDULE_T where TASK_ID=186088;

select * from  apps.PA_PROJ_ELEMENTS where PROJ_ELEMENT_ID=186088 /*AND*\ PROJECT_ID=3391*/;

select * from  apps.PA_PROJ_ELEMENT_VERSIONS where PROJECT_ID=3391 AND PROJ_ELEMENT_ID=186088;--��ø���Ŀ�ڲ�ͬ�汾�µ�wbs�ṹԪ�أ�����PARENT_STRUCTURE_VERSION_IDΪwbs�İ汾��

select * from apps.pa_proj_elem_ver_schedule where PROJ_ELEMENT_ID=186088;

select * from apps.PA_PROJ_ELEM_VER_STRUCTURE where PROJECT_ID=3391 and STATUS_CODE='STRUCTURE_WORKING';--��ȡ��Ŀ��ǰ���ڹ�����wbs�ṹ�İ汾�������м�¼����wbs�İ汾��

select * from  apps.cux_pa_deliverable_t where CUX_DLV_ID=8509;

select D.PROJECT_ID,
       D.NAME,
       D.SEGMENT1,
       C.ELEMENT_NUMBER wbs�б��,
       C.NAME wbs�ڵ���,
       B.ATTRIBUTE1 wbs�ڵ�����,
       F.CUX_DLV_ID ������ID��
       F.DELIVERABLE_ID ������ECM�ĵ�ID,
       F.DOC_TYPE �������ĵ����ͣ�
       F.STATUS ����������״��,
       F.DOC_NAME,
       F.DESIGNER �����,
       F.RELEASE_SPECIALTY ����רҵ,
       F.ACCEPT_SPECIALTY ����רҵ,
       F.DOC_NUM �ĵ���,
       F.DESIGN_NODE ��ƽڵ�,
       F.ACTUAL_COMPLETED_DATE ʵ���������
   
  from 
       apps.PA_PROJECTS_ALL D,
       
       apps.PA_PROJ_ELEMENT_VERSIONS            A,--��ĿԪ�ذ汾��Ϣ
       
       apps.pa_proj_elem_ver_schedule B,  --��Ϊ������ĿԪ�ز�ͬ�汾����չ��Ϣ
       
       apps.PA_PROJ_ELEM_VER_STRUCTURE stc,--����PEV_STRUCTURE_ID�ֶ���Ҫָ��wbs�ṹ��ID
       
       apps.PA_PROJ_ELEMENTS           C��
       apps.cux_pa_deliverable_t F

    where 
       D. PROJECT_ID=C.PROJECT_ID    --����Ŀ�ı����ĿԪ�ر�ʵ��ȫ����

       AND C.PROJ_ELEMENT_ID=F.TASK_ID(+)  --�׶�5��������Ŀ���������ID�ͺ���ĿID��ʵ�ֽ�����ĵĲ���
       AND C.PROJECT_ID=F.PROJECT_ID(+)--�׶�5

       AND C.PROJ_ELEMENT_ID=A.PROJ_ELEMENT_ID--�׶�4��������Ŀ�ź�Ԫ��ID����ȡ��Ŀ��Ӧ������Ԫ��
       
       AND C.PROJECT_ID=A.PROJECT_ID--�׶�4

       AND A.ELEMENT_VERSION_ID=B.ELEMENT_VERSION_ID(+)--2�׶Σ���Ԫ�صİ汾����Ϣ����Ԫ�ذ汾��Ϣ��չ��ͨ�������ӵķ�ʽƴ��
       AND A.PROJ_ELEMENT_ID=B.PROJ_ELEMENT_ID(+) --2�׶�
       
       AND A.PARENT_STRUCTURE_VERSION_ID = stc.element_version_id --1�׶�:��ȡ��ǰ��Ŀ���µ�wbs�ṹ
       and stc.STATUS_CODE = 'STRUCTURE_WORKING'   --1�׶�
       and A.OBJECT_TYPE='PA_TASKS'  --��ȡ����ṹ
       and D.SEGMENT1 LIKE '888'   --1�˴�������Ŀ��ʵ��ģ������
       
       and F.ACTUAL_COMPLETED_DATE is not null
       
         order by A.DISPLAY_SEQUENCE  --Ȼ����Ŀ����wbs�ṹ����ʵ˳���������
