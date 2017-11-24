
select * from apps.PA_PROJECTS_ALL D;

select * from apps.CUX_PA_DLV_SCHEDULE_T where TASK_ID=186088;

select * from  apps.PA_PROJ_ELEMENTS where PROJ_ELEMENT_ID=186088 /*AND*\ PROJECT_ID=3391*/;

select * from  apps.PA_PROJ_ELEMENT_VERSIONS where PROJECT_ID=3391 AND PROJ_ELEMENT_ID=186088;--获得该项目在不同版本下的wbs结构元素，其中PARENT_STRUCTURE_VERSION_ID为wbs的版本号

select * from apps.pa_proj_elem_ver_schedule where PROJ_ELEMENT_ID=186088;

select * from apps.PA_PROJ_ELEM_VER_STRUCTURE where PROJECT_ID=3391 and STATUS_CODE='STRUCTURE_WORKING';--获取项目当前正在工作的wbs结构的版本对象，其中记录的有wbs的版本号

select * from  apps.cux_pa_deliverable_t where CUX_DLV_ID=8509;

select D.PROJECT_ID,
       D.NAME,
       D.SEGMENT1,
       C.ELEMENT_NUMBER wbs列表号,
       C.NAME wbs节点名,
       B.ATTRIBUTE1 wbs节点类型,
       F.CUX_DLV_ID 交付物ID，
       F.DELIVERABLE_ID 交付物ECM文档ID,
       F.DOC_TYPE 交付物文档类型，
       F.STATUS 交付物审批状体,
       F.DOC_NAME,
       F.DESIGNER 设计人,
       F.RELEASE_SPECIALTY 发出专业,
       F.ACCEPT_SPECIALTY 接收专业,
       F.DOC_NUM 文档号,
       F.DESIGN_NODE 设计节点,
       F.ACTUAL_COMPLETED_DATE 实际完成日期
   
  from 
       apps.PA_PROJECTS_ALL D,
       
       apps.PA_PROJ_ELEMENT_VERSIONS            A,--项目元素版本信息
       
       apps.pa_proj_elem_ver_schedule B,  --作为保存项目元素不同版本的扩展信息
       
       apps.PA_PROJ_ELEM_VER_STRUCTURE stc,--其中PEV_STRUCTURE_ID字段主要指定wbs结构的ID
       
       apps.PA_PROJ_ELEMENTS           C，
       apps.cux_pa_deliverable_t F

    where 
       D. PROJECT_ID=C.PROJECT_ID    --将项目的表和项目元素表实现全连接

       AND C.PROJ_ELEMENT_ID=F.TASK_ID(+)  --阶段5：根据项目子项的子项ID和和项目ID，实现交付物的的查找
       AND C.PROJECT_ID=F.PROJECT_ID(+)--阶段5

       AND C.PROJ_ELEMENT_ID=A.PROJ_ELEMENT_ID--阶段4：根据项目号和元素ID，获取项目对应的所有元素
       
       AND C.PROJECT_ID=A.PROJECT_ID--阶段4

       AND A.ELEMENT_VERSION_ID=B.ELEMENT_VERSION_ID(+)--2阶段：将元素的版本的信息表与元素版本信息扩展表通过左链接的方式拼接
       AND A.PROJ_ELEMENT_ID=B.PROJ_ELEMENT_ID(+) --2阶段
       
       AND A.PARENT_STRUCTURE_VERSION_ID = stc.element_version_id --1阶段:获取当前项目最新的wbs结构
       and stc.STATUS_CODE = 'STRUCTURE_WORKING'   --1阶段
       and A.OBJECT_TYPE='PA_TASKS'  --获取任务结构
       and D.SEGMENT1 LIKE '888'   --1此处配置项目号实现模糊搜索
       
       and F.ACTUAL_COMPLETED_DATE is not null
       
         order by A.DISPLAY_SEQUENCE  --然后将项目按照wbs结构的现实顺序进行排序
