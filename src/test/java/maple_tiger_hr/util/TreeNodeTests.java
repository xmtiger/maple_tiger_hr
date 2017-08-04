/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package maple_tiger_hr.util;

import com.mikex.maple_tiger_hr.model.Department;
import com.mikex.maple_tiger_hr.util.TreeNode;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import static org.assertj.core.api.Assertions.assertThat;

import org.junit.Test;

/**
 *
 * @author MikeX
 */
public class TreeNodeTests {
    
    @Test
    public void shouldAddDeparments() throws ParseException{
        
        TreeNode<Department> tree = new TreeNode<>();
        
        Department dept01 = new Department();
        dept01.setId(0);
        dept01.setName("Management");
        dept01.setAddress("121 willibrord");        
        dept01.setBegin_time((new SimpleDateFormat("YYYY-MM-dd").parse("2017-05-01")));
        
        TreeNode<Department> treeNode01 = new TreeNode(dept01);
        
        assertThat(tree.add(treeNode01)).isTrue();
    }
}
