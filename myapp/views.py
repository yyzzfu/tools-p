import hashlib
from django.shortcuts import render, redirect
import datetime
import pymongo
from bson.objectid import ObjectId
from faker import Faker
import random
import time
from myapp import models
from myapp.utils.pagination import Pagination
import requests
import jsonpath


class DoMongo:

    def __init__(self, session_id: str, env=None):
        host = 'dds-bp18b483a48184b41.mongodb.rds.aliyuncs.com'  # 默认使用新QA
        if env.lower() == 'qa':  # 老QA
            host = 'dds-bp173fdc085920341.mongodb.rds.aliyuncs.com'
        self.client = pymongo.MongoClient('mongodb://chat:Mantis20160518@{}:3717'.format(host))
        db = self.client['chat']
        self.collection = db['chats']
        self.session_id = session_id
        self.create_time = self.select_mongo()
        # print('查询会话id：{}的create_time：{}'.format(self.session_id, self.create_time))

    def select_mongo(self):
        result = self.collection.find_one({'_id': ObjectId(self.session_id)})
        create_time = result['create_time']
        return create_time

    def modify_mongo(self):
        create_time = self.create_time
        create_time_f = datetime.datetime.strptime(create_time, "%Y-%m-%d %H:%M:%S")
        time_end = create_time_f - datetime.timedelta(hours=1)
        date_end = time_end.strftime("%Y-%m-%d %H:%M:%S")
        create_time_modify = date_end
        modify_time = {'create_time': create_time}
        new_time = {'$set': {'create_time': create_time_modify}}
        self.collection.update_one(modify_time, new_time)
        # print('修改会话id：{}的create_time成功，查询到修改后的create_time：{}'.format(self.session_id, self.select_mongo()))

    def close_collect(self):
        self.client.close()


# content_select = {
#         "select":
#         [
#             {"company": 1402, "company_info": "新QA--1402"},
#             {"company": 1500, "company_info": "新QA--1500"},
#             {"company": 3401, "company_info": "老QA--3401"},
#             {"company": 3403, "company_info": "新QA--3403"},
#             {"company": 8424, "company_info": "GS--8424"},
#             {"company": 8425, "company_info": "GS--8424"},
#         ]
#     }


def index(request):
    return render(request, "index.html")


def id_card(request):
    if request.method == 'GET':
        return redirect('/index')
    try:
        num = int(request.POST.get('num'))
        if num > 50:
            raise Exception
        f = Faker('zh-CN')
        id_list = []
        a = 0
        age = random.randint(18, 40)
        while True:
            id = f.ssn(age, age + 2)
            if id not in id_list:
                id_list.append(id)
                a += 1
                if a == num:
                    return render(request, "index.html", {"card_or_phone_list": id_list})
    except:
        error_card_or_phone_msg = "请输入1-50之间的整数"
        return render(request, "index.html", {'error_card_or_phone_msg': error_card_or_phone_msg})


def get_phone(request):
    if request.method == 'GET':
        return redirect('/index')
    try:
        num = int(request.POST.get('num'))
        if num > 50:
            raise Exception
        phone_list = []
        a = 0
        time_str = str(int(time.time()))
        phone = int("13" + time_str[1:])
        while True:
            phone_list.append(phone)
            a += 1
            phone += 1
            if a == num:
                return render(request, 'index.html', {"card_or_phone_list": phone_list})
    except:
        error_card_or_phone_msg = "请输入1-50之间的整数"
        return render(request, "index.html", {'error_card_or_phone_msg': error_card_or_phone_msg})


def modify(request):
    if request.method == 'GET':
        return redirect('/index')
    session_id = request.POST.get('session_id')
    env = request.POST.get('env')
    try:
        if len(session_id) != 24:
            raise Exception
        submit_time = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        do = DoMongo(session_id, env)
        create_time = do.select_mongo()
        do.modify_mongo()
        create_time_modify = do.select_mongo()
        do.close_collect()
        env_translation = "新QA"
        if env == "QA":
            env_translation = "老QA"
        # models.Record.objects.create(session_id=session_id, env=env_translation, status="成功",
        #                              crete_time_before=create_time,
        #                              crete_time_after=create_time_modify, submit_time=submit_time)
        create_time = '修改前的create_time：{}'.format(create_time)
        create_time_modify = '修改后的create_time：{}'.format(create_time_modify)
        session_id = '提交的会话id：{}'.format(session_id)
        return render(request, 'index.html',
                      {"session_id": session_id, "create_time": create_time, "create_time_modify": create_time_modify})
    except:
        error_session_id = "提交的会话id：" + session_id
        error_env = env
        if error_env == "QA2":
            error_env = "选择的环境：新QA"
        else:
            error_env = "选择的环境：老QA"
        error_msg = '修改失败！确保选择的环境、输入的会话id正确！'
        return render(request, 'index.html',
                      {"error_msg": error_msg, "error_session_id": error_session_id, "error_env": error_env})


def get_record1(request):
    # record_list = models.Record.objects.all()
    record_list = models.Record.objects.order_by('-submit_time')[:20]
    return render(request, "record.html", {"record_list": record_list})


def get_record(request):
    data_dict = {}
    search_data = request.GET.get('q', "")
    if search_data:
        data_dict["session_id__contains"] = search_data

    queryset = models.Record.objects.filter(**data_dict).order_by("-submit_time")

    page_object = Pagination(request, queryset, page_size=15)

    context = {
        "search_data": search_data,

        "queryset": page_object.page_queryset,  # 分完页的数据
        "page_string": page_object.html()  # 页码
    }
    return render(request, 'record.html', context)


all_company_info = {
    "1402": {"username": "sy-fuyiqiang@1402", "password": "qwer1234", "domain": "b2009.bjmantis.net",
             "test_page_before": "pg-demo2"},
    "3403": {"username": "fuyiqiang@3403", "password": "Qwer1234", "domain": "b2009.bjmantis.net",
             "test_page_before": "pg-demo2"},
    "3401": {"username": "sy-fuyiqiang@3401", "password": "Qwer1234", "domain": "b3003.bjmantis.net",
             "test_page_before": "pg-test"},
    "8424": {"username": "fuyiqiang@8424", "password": "qwer1234", "domain": "b1004.south.bjmantis.cn",
             "test_page_before": "pg-chatn6"},
    "8425": {"username": "fuyiqiang@8425", "password": "Qwer1234", "domain": "b1010.south.bjmantis.cn",
             "test_page_before": "pg-chatn6"},
    "1500": {"username": "fl@1500", "password": "Qwer1234", "domain": "b2010.bjmantis.net",
             "test_page_before": "pg-demo2"}
}


def get_page(request):
    if request.method == 'GET':
        return redirect('/index')
    kf_account = request.POST.get('kf_account')
    company = request.POST.get('company')

    test_page_template = r"https://{}.bjmantis.net/chat/t1/index.html?{}#{}"
    non_trace_page_template = r"https://{}.bjmantis.net/chat/t1/nonTrace.html?{}#{}"
    url_token = r"https://{}/sso/oauth/token"
    url_query_service_group = r"https://{}/msp-war/serviceGroupManage/queryServiceGroup.do"
    url_config_search = r"https://{}/msp-war/chat_ext/configSearch.do"
    url_query_list = r"https://{}/msp-war/oper/baseServiceGroup/queryList.do"

    company_info = all_company_info.get(str(company))

    username = company_info.get("username")
    password = company_info.get("password")
    data_for_token = {"username": username, "password": password, "grant_type": "password_d"}

    domain = company_info.get("domain")

    url_token = url_token.format(domain)
    url_query_service_group = url_query_service_group.format(domain)
    url_config_search = url_config_search.format(domain)
    url_query_list = url_query_list.format(domain)

    headers_for_token = {"Authorization": "Basic bWFudGlzX2NybToxMjM0NTY="}

    s = requests.session()

    # 登录获取access_token
    try:
        res = s.post(url_token, data=data_for_token, headers=headers_for_token)
        access_token = res.json()['access_token']
        access_token = "Bearer " + access_token

        # 获取客服分组名字、id
        data_for_query_service_group = {"account": kf_account}
        headers_for_process = {"Authorization": access_token}
    except:
        kf_account = "输入的客服账号：" + kf_account
        company = "-----选择的公司：" + company
        error_msg = kf_account + company + '-----获取token失败！系统故障，可能正在发版！'
        context = {
            "error_msg_page": error_msg
        }
        return render(request, "index.html", context)
    try:
        res = s.post(url_query_service_group, json=data_for_query_service_group, headers=headers_for_process)
        res_json = res.json()
        res_data = res_json['data']
        service_group_name = jsonpath.jsonpath(res_data, "$..name")
        org_name = jsonpath.jsonpath(res_data, "$..org.name")
        bu_name = jsonpath.jsonpath(res_data, "$..bu.name")
        for i in org_name:
            service_group_name.remove(i)
        for i in bu_name:
            service_group_name.remove(i)
        service_group_name_num = len(service_group_name)

        service_group_id = jsonpath.jsonpath(res_data, "$..id")
        org_id = jsonpath.jsonpath(res_data, "$..org.id")
        bu_id = jsonpath.jsonpath(res_data, "$..bu.id")
        for i in org_id:
            service_group_id.remove(i)
        for i in bu_id:
            service_group_id.remove(i)

        # 查询客服的权重
        service_group_name_and_kf_weight_dict = {}
        for i in service_group_id:
            data_for_query_list = {"serviceGroupId": str(i)}
            res = s.post(url_query_list, json=data_for_query_list, headers=headers_for_process)
            res_json = res.json()
            res_data = res_json['data']
            kf_level_code = jsonpath.jsonpath(res_data, "$..levelCode")
            kf_weight = jsonpath.jsonpath(res_data, "$..weight")
            kf_id = jsonpath.jsonpath(res_data, "$..globalUserId")
            service_group = jsonpath.jsonpath(res_data, "$..serviceGroupName")
            service_group = list(set(service_group))
            kf_id_pre = []
            for j in kf_id:
                kf_id_pre.append(str(j).split('@')[0])
            kf_weight_list = []
            for k in range(len(kf_level_code)):
                kf_level_code_1 = kf_level_code[k]
                kf_weight_1 = kf_weight[k]
                kf_weight_2 = kf_level_code_1 + '(' + str(int(kf_weight_1)) + ')'
                kf_weight_list.append(kf_weight_2)
            kf_id_weight_dict = dict(zip(kf_id_pre, kf_weight_list))
            service_group_name_and_kf_weight_dict[service_group[0]] = kf_id_weight_dict[kf_account]

        # 获取探头id、探头名字
        probe_id_list = []
        probe_name_list = []

        for i in service_group_id:
            data_config_search = {"condition": {"groupIds": [str(i)]}, "pageNum": 1, "pageSize": 100}
            res = s.post(url_config_search, json=data_config_search, headers=headers_for_process)
            probe_id = jsonpath.jsonpath(res.json()['data']["list"], "$..id")
            probe_name = jsonpath.jsonpath(res.json()['data']["list"], "$..configName")
            if isinstance(probe_id, bool):
                probe_id = ['']
            if isinstance(probe_name, bool):
                probe_name = ['']
            probe_id_list.append(probe_id)
            probe_name_list.append(probe_name)
        probe_num = 0  # 计算探头的数量
        for i in probe_id_list:
            for j in i:
                if j:
                    probe_num += 1

        # 探头id、探头名字组成字典
        probe_id_name_dict = {}
        for i in range(len(probe_id_list)):
            for j in range(len(probe_id_list[i])):
                probe_id_name_dict[probe_id_list[i][j]] = probe_name_list[i][j]

        # 获取客服所在客服分组、探头的浏览测试页和无痕测试页
        data_pre = []
        for i in range(len(service_group_name)):
            service_group_name_1 = service_group_name[i]
            probe_id_list_1 = probe_id_list[i]
            for j in probe_id_list_1:
                probe_name_1 = probe_id_name_dict[j]
                test_page = ''
                non_trace_page = ''
                if j:
                    test_page = test_page_template.format(company_info["test_page_before"], company, j)
                    non_trace_page = non_trace_page_template.format(company_info["test_page_before"], company, j)
                data_pre.append(
                    {'kf_account': kf_account + '/权重' + service_group_name_and_kf_weight_dict[service_group_name_1],
                     'service_group_name': service_group_name_1,
                     'probe_name': probe_name_1,
                     'test_page': test_page,
                     'non_trace_page': non_trace_page})
        kf_info = {"kf_account": kf_account, "service_group_name_num": service_group_name_num, "probe_num": probe_num}
        context = {"data_pre": data_pre, "kf_info": kf_info}
        return render(request, "page_list.html", context)
    except:
        kf_account = "输入的客服账号：" + kf_account
        company = "-----选择的公司：" + company
        error_msg_1 = kf_account + company
        error_msg_2 = '查询失败！确保选择的公司、输入的客服账户正确！'
        context = {
            "error_msg_page_1": error_msg_1,
            "error_msg_page_2": error_msg_2,
        }
        return render(request, "index.html", context)


def modify_password(request):
    if request.method == 'GET':
        return redirect('/index')
    kf_account = request.POST.get('kf_account')
    company = request.POST.get('company')

    url_token = r"https://{}/sso/oauth/token"
    url_update_password = r"https://{}/msp-war/userCenter/updatePasswdInfoNew.do"
    url_customer_info_init = r"https://{}/msp-war/customer/customerInfoInit.do"
    company_info = all_company_info.get(str(company))

    username = company_info.get("username")
    password = company_info.get("password")
    data_for_token = {"username": username, "password": password, "grant_type": "password_d"}

    domain = company_info.get("domain")

    url_token = url_token.format(domain)
    url_update_password = url_update_password.format(domain)
    url_customer_info_init = url_customer_info_init.format(domain)

    user_agent = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36"}

    s = requests.session()
    # 登录获取access_token
    headers_for_token = {"Authorization": "Basic bWFudGlzX2NybToxMjM0NTY="}
    headers_for_token.update(user_agent)
    try:
        res = s.post(url_token, data=data_for_token, headers=headers_for_token)
        access_token = res.json()['access_token']
        access_token = "Bearer " + access_token

        headers_base = {"Authorization": access_token}
        headers_base.update(user_agent)
    except:
        kf_account = "输入的客服账号：" + kf_account
        company = "-----选择的公司：" + company
        error_msg = kf_account + company + '-----获取token失败！系统故障，可能正在发版！'
        context = {
            "error_msg_page_password": error_msg,
        }
        return render(request, "index.html", context)
    try:
        res_customer_info_init_json = s.post(url_customer_info_init, headers=headers_base).json()
        userCenterId = kf_account + "@" + str(company)
        user_list = jsonpath.jsonpath(res_customer_info_init_json, "$..users")[0]
        user_dict = [item for item in user_list if item['userCenterId'] == userCenterId]
        user_id = None
        if user_dict:
            user_id = user_dict[0].get('id')

        time_1 = str(int(time.time() * 1000))
        password_new = 'Qwer1234'
        str_1 = str(user_id) + password_new + "aZDMy!BhcrcpNChAkY0AY0&DF^R9&M!8" + time_1
        md5 = hashlib.md5(str_1.encode('utf8')).hexdigest()
        data_update_password = {"userId": user_id, "password": password_new, "time": time_1, "md5": md5}
        res_update_password_json = s.post(url_update_password, json=data_update_password, headers=headers_base).json()
        message = res_update_password_json.get('message')
        if message == "超管账号不能修改密码":
            error_modify = "是超管！" + message + "！"
            context = {
                "kf_account": kf_account,
                "error_modify": error_modify
            }
            return render(request, 'index.html', context)
        elif not message:
            sucess_modify = "重置密码成功！重置后的密码为：{}".format(password_new)
            context = {
                "kf_account_suc": "账号：" + kf_account,
                "sucess_modify": sucess_modify
            }
            return render(request, 'index.html', context)
        kf_account = "输入的客服账号：" + kf_account
        company = "-----选择的公司：" + company
        kf_account_fail = kf_account + company
        context = {
            "kf_account_fail": kf_account_fail,
            "error_modify": "重置密码失败！请输入正确的账号、选择正确的公司！"
        }
        return render(request, 'index.html', context)
    except Exception as e:
        kf_account = "输入的客服账号：" + kf_account
        company = "-----选择的公司：" + company
        kf_account_fail = kf_account + company
        context = {
            "kf_account_fail": kf_account_fail,
            "error_modify": "重置密码失败！请输入正确的账号、选择正确的公司！"
        }
        return render(request, 'index.html', context)


def tantou(request):
    return render(request, 'tantou.html')
