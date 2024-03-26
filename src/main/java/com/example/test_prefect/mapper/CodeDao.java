package com.example.test_prefect.mapper;

import com.example.test_prefect.model.CodeVO;
import com.example.test_prefect.util.WorkDiv;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface CodeDao extends WorkDiv<CodeVO> {
   List<CodeVO> doRetrieve(Map<String,Object> map);

}
