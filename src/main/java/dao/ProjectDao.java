package dao;

import entity.Project;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
public interface ProjectDao extends BaseDao<Project>{
}
