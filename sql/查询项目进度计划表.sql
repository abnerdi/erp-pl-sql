select * from apps.PA_PROJECTS_ALL D;

select * from apps.CUX_PA_DLV_SCHEDULE_T where TASK_ID=186088;

select * from  apps.PA_PROJ_ELEMENTS where PROJ_ELEMENT_ID=186088 /*AND*\ PROJECT_ID=3391*/;

select * from  apps.PA_PROJ_ELEMENT_VERSIONS where PROJECT_ID=3391 AND PROJ_ELEMENT_ID=186088;--��ø���Ŀ�ڲ�ͬ�汾�µ�wbs�ṹԪ�أ�����PARENT_STRUCTURE_VERSION_IDΪwbs�İ汾��

select * from apps.pa_proj_elem_ver_schedule where PROJ_ELEMENT_ID=186088;

select * from apps.PA_PROJ_ELEM_VER_STRUCTURE where PROJECT_ID=3391 and STATUS_CODE='STRUCTURE_WORKING';--��ȡ��Ŀ��ǰ���ڹ�����wbs�ṹ�İ汾�������м�¼����wbs�İ汾��

/*select * from  apps.cux_pa_deliverable_t ;*/

select   
       D.PROJECT_ID,
       D.NAME,
       D.SEGMENT1,
       C.ELEMENT_NUMBER wbs�б��,
       C.NAME wbs�ڵ���,
       B.ATTRIBUTE1 wbs�ڵ�����,
       
       
       JD.DESIGN_NODE ���ȼƻ�����ƽڵ���,
       JD.APPROVE_STATUS ���ȼƻ�������״̬,
       JD.NODE_TYPE �ڵ�����,
       JD.RELEASE_SPECIALTY ����רҵ
          
  from 
       apps.PA_PROJECTS_ALL D,
       
       apps.PA_PROJ_ELEMENT_VERSIONS            A,--��ĿԪ�ذ汾��Ϣ
       
       apps.pa_proj_elem_ver_schedule B,  --��Ϊ������ĿԪ�ز�ͬ�汾����չ��Ϣ
       
       apps.PA_PROJ_ELEM_VER_STRUCTURE stc,--����PEV_STRUCTURE_ID�ֶ���Ҫָ��wbs�ṹ��ID
       
       apps.PA_PROJ_ELEMENTS           C,
       
       apps.CUX_PA_DLV_SCHEDULE_T      JD --���ȼƻ���

    where 
       D.PROJECT_ID=C.PROJECT_ID  --����Ŀ�ı����ĿԪ�ر�ʵ��ȫ����

       AND C.PROJ_ELEMENT_ID=JD.TASK_ID(+)  --�׶�5��������Ŀ���������ID�ͺ���ĿID��ʵ�ֽ��ȼƻ���Ĳ���
       AND C.PROJECT_ID=JD.PROJECT_ID(+)--�׶�5

       AND C.PROJ_ELEMENT_ID=A.PROJ_ELEMENT_ID--�׶�4��������Ŀ�ź�Ԫ��ID����ȡ��Ŀ��Ӧ������Ԫ��
       
       AND C.PROJECT_ID=A.PROJECT_ID--�׶�4

       AND A.ELEMENT_VERSION_ID=B.ELEMENT_VERSION_ID(+)--2�׶Σ���Ԫ�صİ汾����Ϣ����Ԫ�ذ汾��Ϣ��չ��ͨ�������ӵķ�ʽƴ��
       AND A.PROJ_ELEMENT_ID=B.PROJ_ELEMENT_ID(+) --2�׶�
       
       AND A.PARENT_STRUCTURE_VERSION_ID = stc.element_version_id --1�׶�:��ȡ��ǰ��Ŀ���µ�wbs�ṹ
       and stc.STATUS_CODE = 'STRUCTURE_WORKING'   --1�׶�
       and A.OBJECT_TYPE='PA_TASKS'  --��ȡ����ṹ
       and D.SEGMENT1 LIKE '888'   --1�˴�������Ŀ��ʵ��ģ������
       
         order by A.DISPLAY_SEQUENCE  --Ȼ����Ŀ����wbs�ṹ����ʵ˳���������
