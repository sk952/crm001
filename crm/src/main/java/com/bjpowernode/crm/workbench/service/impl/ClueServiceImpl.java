package com.bjpowernode.crm.workbench.service.impl;

import com.bjpowernode.crm.utils.DateTimeUtil;
import com.bjpowernode.crm.utils.UUIDUtil;
import com.bjpowernode.crm.workbench.dao.*;
import com.bjpowernode.crm.workbench.domain.*;
import com.bjpowernode.crm.workbench.service.ClueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Author:孙康
 * 2019/11/28
 */
@Service
public class ClueServiceImpl implements ClueService {

    @Autowired
    private ClueDao clueDao;

    @Autowired
    private ClueActivityRelationDao clueActivityRelationDao;

    @Autowired
    private ClueRemarkDao clueRemarkDao;

    @Autowired
    private CustomerDao customerDao;

    @Autowired
    private CustomerRemarkDao customerRemarkDao;

    @Autowired
    private ContactsDao contactsDao;

    @Autowired
    private ContactsRemarkDao contactsRemarkDao;

    @Autowired
    private ContactsActivityRelationDao contactsActivityRelationDao;

    @Autowired
    private TranDao tranDao;

    @Autowired
    private TranHistoryDao tranHistoryDao;


    @Override
    public void saveClue(Clue c) {

        clueDao.saveClue(c);

    }

    @Override
    public Clue getClueByIdForOwner(String id) {

        Clue c = clueDao.getClueByIdForOwner(id);

        return c;
    }

    @Override
    public void deleteRelationById(String id) {

        clueActivityRelationDao.deleteRelationById(id);

    }

    @Override
    public void saveRelation(String clueId, String[] activityIds) {

        /*

            遍历市场活动Id数组
            取得每一个市场活动Id，让每一个市场活动Id与clueId做关联

            例如添加3条记录，以下做法是一条一条添加，dao层执行了3次，程序执行效率比较低，响应时间比较长

         */
        /*for(String activityId:activityIds){

            ClueActivityRelation car = new ClueActivityRelation();
            car.setId(UUIDUtil.getUUID());
            car.setActivityId(activityId);
            car.setClueId(clueId);

            clueActivityRelationDao.saveRalation(car);

        }*/

        //以下我们使用批量添加的方式

        List<ClueActivityRelation> clueActivityRelationList = new ArrayList<>();

        for(String activityId:activityIds){

            ClueActivityRelation car = new ClueActivityRelation();
            car.setId(UUIDUtil.getUUID());
            car.setActivityId(activityId);
            car.setClueId(clueId);

            clueActivityRelationList.add(car);

        }

        //dao层只执行一次，执行效率比较高，响应时间比较短，推荐使用
        clueActivityRelationDao.saveRalationList(clueActivityRelationList);


    }

    @Override
    public boolean convert(String clueId, Tran t, String flag, String createBy) {

        /*

            1.通过线索的id，查询线索这条记录的详细信息（根据id查单条）
                目的是为了转换客户和联系人
                线索中包含了公司相关的信息，以及人相关的信息
                我们要将线索对象中与公司相关的信息提取出来，生成客户
                我们要将线索对象中与人相关的信息提取出来，生成联系人

         */

        Clue c = clueDao.getById(clueId);

        /*

            2.从以上c对象中，取出公司名称
                通过公司名称到客户表中去查询，有没有这个客户
                如果有，则将客户查询出来，提取id信息（未来的业务要使用到）
                如果没有，则根据该c对象中提取出来的公司名称，新建一个客户，提取id信息（未来的业务要使用到）


         */

        //取得公司名称
        String company = c.getCompany();

        //拿着以上公司名称到客户表中去查，看看有没有这个客户
        /*

            查询方式：
            1.我们要按照公司的名称，进行精确匹配查询，我们要使用的是=做条件连接符，而不是like
                select....where name=xxx
            2.我们要查询的是有没有，可以使用如下方式进行查询

                方式1：
                int count = select count(*) from tbl_customer where name=xxx
                count==0:没有这个公司，需要新建一个
                count==1:有这个公司，不需要新建，虽然查到了，但是想要公司的其他信息（比如id信息），是取不到的

                方式2：
                Customer cus = select * from tbl_customer where name=xxx
                cus==null:没有这个公司，需要新建一个
                cus!=null:有这个公司，我们现在想要取得公司的信息，就从cus对象中get就可以了

         */

        Customer cus = customerDao.getCusByName(company);

        if(cus==null){

            //如果进入到if语句块，说明没有这个客户，需要生成一个客户
            //通过线索对象中关于公司信息的提取，然后生成客户的过程，就叫做线索的转换

            cus = new Customer();

            cus.setId(UUIDUtil.getUUID());
            cus.setName(company);
            cus.setCreateBy(createBy);
            cus.setCreateTime(DateTimeUtil.getSysTime());
            cus.setWebsite(c.getWebsite());
            cus.setPhone(c.getPhone());
            cus.setOwner(c.getOwner());
            cus.setNextContactTime(c.getNextContactTime());
            cus.setDescription(c.getDescription());
            cus.setContactSummary(c.getContactSummary());
            cus.setAddress(c.getAddress());

            customerDao.saveCustomer(cus);


        }


        /*


            第二步完成之后，如果将来的步骤要使用客户的id

            我们直接使用 cus.getId()


         */


        /*

            3.从第一步生成的c对象中，提取人相关的信息，生成联系人

         */

        Contacts con = new Contacts();
        con.setId(UUIDUtil.getUUID());
        con.setCreateBy(createBy);
        con.setCreateTime(DateTimeUtil.getSysTime());
        con.setSource(c.getSource());
        con.setOwner(c.getOwner());
        con.setNextContactTime(c.getNextContactTime());
        con.setMphone(c.getMphone());
        con.setJob(c.getJob());
        con.setFullname(c.getFullname());
        con.setEmail(c.getEmail());
        con.setDescription(c.getDescription());
        con.setCustomerId(cus.getId());
        con.setContactSummary(c.getContactSummary());
        con.setAppellation(c.getAppellation());
        con.setAddress(c.getAddress());

        contactsDao.saveContacts(con);

        /*


            第三步完成之后，如果将来的步骤要使用联系人的id

            我们直接使用 con.getId()


         */

        /*

            4.取得该线索关联的备注信息列表，将该列表信息备份到客户备注以及联系人备注中去

         */

        //查询线索关联的备注信息列表
        List<ClueRemark> clueRemarkList = clueRemarkDao.getRemarkListByClueId(clueId);

        List<CustomerRemark> customerRemarkList = new ArrayList<>();

        List<ContactsRemark> contactsRemarkList = new ArrayList<>();


        //遍历备注列表
        for(ClueRemark clueRemark : clueRemarkList){

            //取得每一个备注信息
            String noteContent = clueRemark.getNoteContent();

            //创建客户备注
            CustomerRemark customerRemark = new CustomerRemark();
            customerRemark.setId(UUIDUtil.getUUID());
            customerRemark.setCreateBy(createBy);
            customerRemark.setCreateTime(DateTimeUtil.getSysTime());
            customerRemark.setNoteContent(noteContent);
            customerRemark.setEditFlag("0");
            customerRemark.setCustomerId(cus.getId());
            customerRemarkList.add(customerRemark);

            //创建联系人备注
            ContactsRemark contactsRemark = new ContactsRemark();
            contactsRemark.setId(UUIDUtil.getUUID());
            contactsRemark.setCreateBy(createBy);
            contactsRemark.setCreateTime(DateTimeUtil.getSysTime());
            contactsRemark.setNoteContent(noteContent);
            contactsRemark.setEditFlag("0");
            contactsRemark.setContactsId(con.getId());
            contactsRemarkList.add(contactsRemark);


        }

        //添加客户备注集合信息
        customerRemarkDao.saveCustomerRemarkList(customerRemarkList);

        //添加联系人备注集合信息
        contactsRemarkDao.saveContactsRemarkList(contactsRemarkList);


        /*

            5.查询该线索与市场活动关联的列表信息，将线索和市场活动的关联关系，转换（备份）为联系人和市场活动的关联关系


         */

        //查询该线索与市场活动关联的列表信息
        List<ClueActivityRelation> clueActivityRelationList = clueActivityRelationDao.getRelationListByClueId(clueId);

        List<ContactsActivityRelation> contactsActivityRelationList = new ArrayList<>();

        //遍历关联关系列表
        for(ClueActivityRelation clueActivityRelation : clueActivityRelationList){

            //取得每一个关联的市场活动id
            String activityId = clueActivityRelation.getActivityId();

            //创建联系人和市场活动的关联关系
            ContactsActivityRelation contactsActivityRelation = new ContactsActivityRelation();
            contactsActivityRelation.setId(UUIDUtil.getUUID());
            contactsActivityRelation.setContactsId(con.getId());
            contactsActivityRelation.setActivityId(activityId);
            contactsActivityRelationList.add(contactsActivityRelation);

        }

        //添加联系人和市场活动的关联关系列表信息
        contactsActivityRelationDao.saveRelationList(contactsActivityRelationList);

        //6.判断flag，如果有创建交易的需求，我们需要创建一条交易
        if("a".equals(flag)){

            //进入到if语句块，说明需要创建交易
            /*

                在控制器当中，已经为t对象封装了一些基础信息
                money
                name
                expectedDate
                stage
                activityId
                id
                createBy
                createTime

                其他的信息，我们由以上步骤得到的信息去尽量的填充进去

             */

            t.setSource(c.getSource());
            t.setOwner(c.getOwner());
            t.setNextContactTime(c.getNextContactTime());
            t.setDescription(c.getDescription());
            t.setCustomerId(cus.getId());
            t.setContactSummary(c.getContactSummary());
            t.setContactsId(con.getId());

            //添加交易
            tranDao.saveTran(t);

            //7.每一次添加交易之后，要伴随着该交易生成一条交易历史，用来记录该交易的重要信息
            //注意：交易历史的创建，也同样要写在if语句块中，只有创建交易了，才会创建交易历史
            TranHistory th = new TranHistory();
            th.setId(UUIDUtil.getUUID());
            th.setCreateBy(createBy);
            th.setCreateTime(DateTimeUtil.getSysTime());
            th.setExpectedDate(t.getExpectedDate());
            th.setStage(t.getStage());
            th.setMoney(t.getMoney());
            th.setTranId(t.getId());

            //添加交易历史
            tranHistoryDao.saveTranHistory(th);


        }

/*        //8.删除线索关联的所有备注
        clueRemarkDao.deleteRemarkByClueId(clueId);

        //9.删除线索和市场活动的所有关联关系
        clueActivityRelationDao.deleteRelationByClueId(clueId);

        //10.删除线索
        clueDao.deleteClueById(clueId);*/

        return true;
    }


}
