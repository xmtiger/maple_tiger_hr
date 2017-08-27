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
    
    //this test is for root (empty data) with children (non-empty) test
    @Test
    public void testDepartmentAddNodeMethod() throws ParseException {
        TreeNode<Department> tree = new TreeNode<>();
        int id = 0;
        
        Department dept01 = new Department();
        dept01.setId(++id);
        dept01.setName("Management");
        dept01.setAddress("121 willibrord, verdun, Q.C");        
        dept01.setBegin_time((new SimpleDateFormat("YYYY-MM-dd").parse("2017-05-01")));
        
        TreeNode<Department> treeNode01 = new TreeNode(dept01);
        
        assertThat(tree.addNode1(treeNode01)).isTrue();
        
        Department dept02 = new Department();
        dept02.setId(++id);
        dept02.setName("Engineering");
        dept02.setAddress("121 willibrord, verdun, Q.C");        
        dept02.setBegin_time((new SimpleDateFormat("YYYY-MM-dd").parse("2017-05-01")));
        
        TreeNode<Department> treeNode02 = new TreeNode(dept02);
        assertThat(tree.addNode1(treeNode02)).isTrue();
        
        Department dept03 = new Department();
        dept03.setId(++id);
        dept03.setName("Accounting");
        dept03.setAddress("121 willibrord, verdun, Q.C");        
        dept03.setBegin_time((new SimpleDateFormat("YYYY-MM-dd").parse("2017-05-01")));
        
        TreeNode<Department> treeNode03 = new TreeNode(dept03);
        assertThat(tree.addNode1(treeNode03)).isTrue();
        
        Department dept021 = new Department();
        dept021.setId(++id);
        dept021.setName("Civil Structural");
        dept021.setAddress("121 willibrord, verdun, Q.C");        
        dept021.setBegin_time((new SimpleDateFormat("YYYY-MM-dd").parse("2017-05-01")));
        dept021.setFather(dept02);
        
        //dept02.addChild(dept021);
        
        TreeNode<Department> treeNode021 = new TreeNode(dept021);
        assertThat(tree.addNode1(treeNode021)).isTrue();
        
        Department dept022 = new Department();
        dept022.setId(++id);
        dept022.setName("Mechanical");
        dept022.setAddress("121 willibrord, verdun, Q.C");        
        dept022.setBegin_time((new SimpleDateFormat("YYYY-MM-dd").parse("2017-05-01")));
        dept022.setFather(dept02);
        //dept02.addChild(dept022);
        
        TreeNode<Department> treeNode022 = new TreeNode(dept022);
        assertThat(tree.addNode1(treeNode022)).isTrue();
                
        System.out.println(tree);
        
        Department dept0211 = new Department();
        dept0211.setId(++id);
        dept0211.setName("Civil Structural Drafting");
        dept0211.setAddress("121 willibrord, verdun, Q.C");        
        dept0211.setBegin_time((new SimpleDateFormat("YYYY-MM-dd").parse("2017-05-01")));
        dept0211.setFather(dept021);
        
        //dept02.addChild(dept021);
        
        TreeNode<Department> treeNode0211 = new TreeNode(dept0211);
        assertThat(tree.addNode1(treeNode0211)).isTrue();
        
        
        //test update method
        Department dept02m = new Department();
        dept02m.setId(dept02.getId());
        dept02m.copyFrom(dept02);
        dept02m.setName("Engineering - Industrial");
        
        assertThat(tree.update(new TreeNode(dept02m))).isTrue();
        System.out.println(tree);
        
        // test remove method
        assertThat(tree.remove(treeNode021, true)).isFalse();
        System.out.println(tree);
        
        assertThat(tree.remove(treeNode03, false)).isTrue();
        System.out.println(tree);
        
        assertThat(tree.remove(treeNode02, false)).isTrue();
        System.out.println(tree);
        
        assertThat(tree.remove(treeNode02, false)).isFalse();
        System.out.println(tree);
        
        System.out.println("\nend of testDepartmentAddNodeMethod()");
        System.out.println("---------------------------------------------------");
    }
    
    /*@Test
    public void testDeparmentsWithoutRoot() throws ParseException{
        
        TreeNode<Department> tree = new TreeNode<>();
        int id = 0;
        
        Department dept01 = new Department();
        dept01.setId(++id);
        dept01.setName("Management");
        dept01.setAddress("121 willibrord, verdun, Q.C");        
        dept01.setBegin_time((new SimpleDateFormat("YYYY-MM-dd").parse("2017-05-01")));
        
        TreeNode<Department> treeNode01 = new TreeNode(dept01);
        
        assertThat(tree.add(treeNode01)).isTrue();
        
        Department dept02 = new Department();
        dept02.setId(++id);
        dept02.setName("Engineering");
        dept02.setAddress("121 willibrord, verdun, Q.C");        
        dept02.setBegin_time((new SimpleDateFormat("YYYY-MM-dd").parse("2017-05-01")));
        
        TreeNode<Department> treeNode02 = new TreeNode(dept02);
        assertThat(tree.add(treeNode02)).isTrue();
        
        Department dept03 = new Department();
        dept03.setId(++id);
        dept03.setName("Accounting");
        dept03.setAddress("121 willibrord, verdun, Q.C");        
        dept03.setBegin_time((new SimpleDateFormat("YYYY-MM-dd").parse("2017-05-01")));
        
        TreeNode<Department> treeNode03 = new TreeNode(dept03);
        assertThat(tree.add(treeNode03)).isTrue();
        
        Department dept021 = new Department();
        dept021.setId(++id);
        dept021.setName("Civil Structural");
        dept021.setAddress("121 willibrord, verdun, Q.C");        
        dept021.setBegin_time((new SimpleDateFormat("YYYY-MM-dd").parse("2017-05-01")));
        
        TreeNode<Department> treeNode021 = new TreeNode(dept021);
        assertThat(treeNode02.add(treeNode021)).isTrue();
        
        Department dept022 = new Department();
        dept022.setId(++id);
        dept022.setName("Mechanical");
        dept022.setAddress("121 willibrord, verdun, Q.C");        
        dept022.setBegin_time((new SimpleDateFormat("YYYY-MM-dd").parse("2017-05-01")));
        
        TreeNode<Department> treeNode022 = new TreeNode(dept022);
        assertThat(treeNode02.add(treeNode022)).isTrue();
                
        System.out.println(tree);
        
        //test update method
        Department dept02m = new Department();
        dept02m.setId(dept02.getId());
        dept02m.copyFrom(dept02);
        dept02m.setName("Engineering - Industrial");
        
        assertThat(tree.update(new TreeNode(dept02m))).isTrue();
        System.out.println(tree);
        
        // test remove method
        assertThat(tree.remove(treeNode021, true)).isTrue();
        System.out.println(tree);
        
        assertThat(tree.remove(treeNode03, false)).isTrue();
        System.out.println(tree);
        
        assertThat(tree.remove(treeNode02, false)).isTrue();
        System.out.println(tree);
        
        assertThat(tree.remove(treeNode02, false)).isFalse();
        System.out.println(tree);
        
        System.out.println("\nend of testDepartmentWithoutRoot()");
        System.out.println("---------------------------------------------------");
    }
    
    //this test is for root (non empty data) with children (non-empty) test
    @Test
    public void testDeparmentsWithRoot() throws ParseException{
        
        //TreeNode<Department> tree = new TreeNode<>();
        int id = 0;
        
        Department dept01 = new Department();
        dept01.setId(++id);
        dept01.setName("Company");
        dept01.setAddress("121 willibrord, verdun, Q.C");        
        dept01.setBegin_time((new SimpleDateFormat("YYYY-MM-dd").parse("2017-05-01")));
        
        TreeNode<Department> tree = new TreeNode(dept01);
        
        //assertThat(tree.add(treeNode01)).isTrue();
        
        Department dept02 = new Department();
        dept02.setId(++id);
        dept02.setName("Engineering");
        dept02.setAddress("121 willibrord, verdun, Q.C");        
        dept02.setBegin_time((new SimpleDateFormat("YYYY-MM-dd").parse("2017-05-01")));
        
        TreeNode<Department> treeNode02 = new TreeNode(dept02);
        assertThat(tree.add(treeNode02)).isTrue();
        
        Department dept03 = new Department();
        dept03.setId(++id);
        dept03.setName("Accounting");
        dept03.setAddress("121 willibrord, verdun, Q.C");        
        dept03.setBegin_time((new SimpleDateFormat("YYYY-MM-dd").parse("2017-05-01")));
        
        TreeNode<Department> treeNode03 = new TreeNode(dept03);
        assertThat(tree.add(treeNode03)).isTrue();
        
        Department dept021 = new Department();
        dept021.setId(++id);
        dept021.setName("Civil Structural");
        dept021.setAddress("121 willibrord, verdun, Q.C");        
        dept021.setBegin_time((new SimpleDateFormat("YYYY-MM-dd").parse("2017-05-01")));
        
        TreeNode<Department> treeNode021 = new TreeNode(dept021);
        assertThat(treeNode02.add(treeNode021)).isTrue();
        
        Department dept022 = new Department();
        dept022.setId(++id);
        dept022.setName("Mechanical");
        dept022.setAddress("121 willibrord, verdun, Q.C");        
        dept022.setBegin_time((new SimpleDateFormat("YYYY-MM-dd").parse("2017-05-01")));
        
        TreeNode<Department> treeNode022 = new TreeNode(dept022);
        assertThat(treeNode02.add(treeNode022)).isTrue();
        
        System.out.println(tree);
        
        //test update method
        Department dept02m = new Department();
        dept02m.setId(dept02.getId());
        dept02m.copyFrom(dept02);
        dept02m.setName("Engineering - Industrial");
        
        assertThat(tree.update(new TreeNode(dept02m))).isTrue();
        System.out.println(tree);
        
        // test remove method
        assertThat(tree.remove(treeNode021, true)).isTrue();
        System.out.println(tree);
        
        assertThat(tree.remove(treeNode03, false)).isTrue();
        System.out.println(tree);
        
        assertThat(tree.remove(treeNode02, false)).isTrue();
        System.out.println(tree);
        
        assertThat(tree.remove(treeNode02, false)).isFalse();
        System.out.println(tree);
        
        System.out.println("\nend of testDepartmentWithRoot()");
        System.out.println("---------------------------------------------------");
    }*/
}
