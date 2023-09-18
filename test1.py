import hashlib
import time
import requests
import jsonpath

my = "0931c7cada078189de7166ea75cdd92d"
companyId = 1402
url = r"http://qa2api.bjmantis.net/api/chatApiCon/queryChatList"


time_str = str(int(time.time() * 1000))
str_1 = my + time_str
md5 = hashlib.md5(str_1.encode('utf8')).hexdigest()

data = {"startTime": "2023-08-30 00:00:00",
        "endTime": "2023-08-31 00:00:00",
        "pageNum": 1,
        "pageSize": 300,
        "time": time_str,
        "token": md5,
        "companyId": companyId
        }

res = requests.post(url, json=data)
print(res.content)
res_json = res.json()


chat_id_list = jsonpath.jsonpath(res_json, "$..chatId")
type_list = jsonpath.jsonpath(res_json, "$..receptionType")
chat_num = len(chat_id_list)
type_num = len(type_list)
print("会话数：" + str(type_num))
print("接待类型数：" + str(type_num))
if (chat_num == type_num) and chat_num >= 1:
        for i in range(len(chat_id_list)):
                print(chat_id_list[i] + "---------" + type_list[i])
else:
        print("查询的数据有问题")
