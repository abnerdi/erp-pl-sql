select *
  from apps.PA_PROJ_ELEM_VER_STRUCTURE stc,--其中PEV_STRUCTURE_ID字段主要指定wbs结构的ID
       apps.PA_PROJ_ELEMENT_VERSIONS            A

    where 
       
       A.PARENT_STRUCTURE_VERSION_ID = stc.element_version_id --1阶段:获取当前项目最新的wbs结构
       and stc.STATUS_CODE = 'STRUCTURE_WORKING'   --1阶段
       and A.OBJECT_TYPE='PA_TASKS'  --获取任务结构
       and A.PROJECT_ID=3391   --1阶段
       
         order by A.DISPLAY_SEQUENCE  --然后将项目按照wbs结构的现实顺序进行排序
