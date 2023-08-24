import jsonpath


res_customer_info_init_json = [{"id":32033,"userCenterId":"sy-kf24@1402"},
                               {"id": 32032, "userCenterId": "sy-kf25@1402"}]
user_id = jsonpath.jsonpath(res_customer_info_init_json, "$..userCenterId[@.sy-kf24@1402]")
print(user_id)