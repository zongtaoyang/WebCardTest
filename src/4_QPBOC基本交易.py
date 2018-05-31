# -*- coding: GBK -*
# '''
# //测试目的：本测试先进行非接触PBOC交易同时对电子现金进行充值，之后进行QPBOC的消费交易
# //测试流程：非接触PBOC交易：终端设置支持“非接触PBOC”，卡片由QPBOC的流程进入PBOC交易，并进行电子现金余额的充值交易；
# //          再次进行QPBOC的交易
# //          QPBOC的交易进行三次，第一次：金额较小值的消费，终端可联机，脱机交易成功；
# //                               第二次：金额较大值的消费，终端仅脱机，脱机交易成功（此次交易后“9F79”变为0）；
# '''

import traceback
import sys
import os
import time
import re
import logging
import logging.config
import DMT.Reader.pcsc.PCSC_fun as PCSC
from DMTDllFun import *
from DMTToolFun import *

__version__ = '0.0.1'
logging.config.fileConfig("logging.conf")
_log = logging.getLogger("DMT.low.mid.high")
# ;***********************************卡片请求联机处理*********************************
# ;三个对称密钥
UDK_AC = 'AE584A1029F831E35ED9389249253846'
UDK_MAC = 'AE584A1029F831E35ED9389249253846'
UDK_ENC = 'AE584A1029F831E35ED9389249253846'

FS8 = '02|08|09|0A|0B|80|81|82|'
NCAS = []
NCAS.append(
    'BCF59BAD16E50EED1144F90207E7EB479CD0CC8D2A0A79BA84B03CD30CAFF283C65FF53D3FC313D068CF6A1A020B22B720FE5E33B824DDCAF02658F638BE342CFC4B39269CADB50025328C06DAB81448A7B521228AF8B9946212A83C561CA65A7149A7C3AF7ACE93EDDF22AB760C83965D51322491560C2452F15FA3950F54101893647712A1A23CB72A2F0745D6467B')
NCAS.append(
    'B61645EDFD5498FB246444037A0FA18C0F101EBD8EFA54573CE6E6A7FBF63ED21D66340852B0211CF5EEF6A1CD989F66AF21A8EB19DBD8DBC3706D135363A0D683D046304F5A836BC1BC632821AFE7A2F75DA3C50AC74C545A754562204137169663CFCC0B06E67E2109EBA41BC67FF20CC8AC80D7B6EE1A95465B3B2657533EA56D92D539E5064360EA4850FED2D1BF')
NCAS.append(
    'EB374DFC5A96B71D2863875EDA2EAFB96B1B439D3ECE0B1826A2672EEEFA7990286776F8BD989A15141A75C384DFC14FEF9243AAB32707659BE9E4797A247C2F0B6D99372F384AF62FE23BC54BCDC57A9ACD1D5585C303F201EF4E8B806AFB809DB1A3DB1CD112AC884F164A67B99C7D6E5A8A6DF1D3CAE6D7ED3D5BE725B2DE4ADE23FA679BF4EB15A93D8A6E29C7FFA1A70DE2E54F593D908A3BF9EBBD760BBFDC8DB8B54497E6C5BE0E4A4DAC29E5')
NCAS.append(
    'C4075AA1EDFA9E5ACD48E05ED159085D23DFD722F38A299C9EF6E9C378D2F9CE1CD52C205349A7E3155C22B049FAE1937B8A28F22C80CF34FB651065EFBA24FEEEBC0D41FB9F5AE381782D9E10FDE1926F01C9FE82AD557BAB2527346A9D0A141047E30A264E0EB8EBAA7C7AA83B809F74FE8CC78A8172982FEF30FB47B7AE6005070DAF19BF8BD90B232FAE556E230357191F111E3B590A969878B16D674FFAD93B45ACB54AEAEF7F5F678ACFF4CC21')
NCAS.append(
    'CF9FDF46B356378E9AF311B0F981B21A1F22F250FB11F55C958709E3C7241918293483289EAE688A094C02C344E2999F315A72841F489E24B1BA0056CFAB3B479D0E826452375DCDBB67E97EC2AA66F4601D774FEAEF775ACCC621BFEB65FB0053FC5F392AA5E1D4C41A4DE9FFDFDF1327C4BB874F1F63A599EE3902FE95E729FD78D4234DC7E6CF1ABABAA3F6DB29B7F05D1D901D2E76A606A8CBFFFFECBD918FA2D278BDB43B0434F5D45134BE1C2781D157D501FF43E5F1C470967CD57CE53B64D82974C8275937C5D8502A1252A8A5D6088A259B694F98648D9AF2CB0EFD9D943C69F896D49FA39702162ACB5AF29B90BADE005BC157')
NCAS.append(
    'CCDBA686E2EFB84CE2EA01209EEB53BEF21AB6D353274FF8391D7035D76E2156CAEDD07510E07DAFCACABB7CCB0950BA2F0A3CEC313C52EE6CD09EF00401A3D6CC5F68CA5FCD0AC6132141FAFD1CFA36A2692D02DDC27EDA4CD5BEA6FF21913B513CE78BF33E6877AA5B605BC69A534F3777CBED6376BA649C72516A7E16AF85')
NCAS.append(
    'A792351A56B28712F07A8F61C15F2B8A1C8C103842497EC6CA65C648E23AE775F8917646678B9DD3CB03048275190ACA5625ADDDBA2E44D25B5F4E515E855F175248DA3EAB44139F0BC706EEC5E736698E45690DC875CCC36056F6B942728E5AC1887A2DF0F4B58ECBC929D5E3DCA8466E5AF0903A3E5D8E3F1A6E2558230B2AF6F61AEFA89741CCF4F50DDC51AA047F')
NCAS.append(
    'AE65C67073421511357568A65DB190908B9DAFC894CCAB37657CA489DADB65677E959B4EDFF9DE13EAAFEDCDC75C1AB0428F3B9FF59BDB0FEC44502A15D4EC022D0D91291194C91A63F4EE981770644D07AEBE682A5B34D46E0A36C589F9808323F99ED70691EB682F7E8E8976B14AF00B0C586E5A1AADB3F1B11B3E1202238D588F423D38E1226345B719943AD2FEB2258E8923F2649E4777EC12D1898CE317')

ECAS = ['03', '03', '03', '03', '03', '010001', '010001', '010001']

TerRandNum = '55667788'
Authmoney = '000000000005'

# ;复位
_log.debug("【==================== 复位卡片 ======================】: ")
A = PCSC.PCSC_FUN()
ReaderList = A.ReaderList()
_log.debug("智能卡读写器列表: ")
_log.debug(ReaderList)
A.reader = ReaderList[0]
A.Reset()

# ;***********应用选择*******
_log.debug("【==================== 应用选择 ======================】: ")
# ;select PPSE
APDU = '00 A4 04 00 0E 32 50 41 59 2E 53 59 53 2E 44 44 46 30 31'
A.APDU(APDU, '9000')
# ;select DF01
APDU = '00 A4 04 00 08 A0 00 00 03 33 01 01 01'
A.APDU(APDU, '9000')

# ;终端支持非接触PBOC
# ;"9F02"=000000000005

_log.debug("【==================== 应用初始化 ======================】: ")
# ;GPO
# ;寻找9F38的值域
responsestr = A.RecvData
num, postion = StrFind(responsestr, "9F38")
if (num == 0):
    _log.debug("【==================== 用例执行失败 ======================】: ")
    raise Exception

result, VAL_6F = FindValforTag(A.RecvData, "6F")
# print (result,VAL_6F)
if (result != "01"):
    _log.debug("【==================== 用例执行失败 ======================】: ")
    raise Exception

result, A5VAL = FindValforTag(VAL_6F, "A5")
if (result != "01"):
    _log.debug("【==================== 用例执行失败 ======================】: ")
    raise Exception

result, val_9F38 = FindValforTag(A5VAL, "9F38")
if (result != "01"):
    _log.debug("【==================== 用例执行失败 ======================】: ")
    raise Exception

tags = "8A9F7A9F029F039F1A955F2A9A9C9F379F219F4E9F339F66DF69DF60"
valfortags = "3030,02,000000000005,000000000003,0156,0000000000,0156,100322,02,55667788,131534,0102030405060708091A0B0C0D0E0F1011121314,E020C0,F6000000,00,00#"
ret, PDOL = LinkValueByTag(tags, valfortags, val_9F38)
# print (ret,val_9F38,PDOL)
if (ret == 0):
    _log.debug("【==================== 用例执行失败 ======================】: ")
    raise Exception
PDOLLEN = len(PDOL) / 2
PDOLDATA = '83' + "%02x" % PDOLLEN + PDOL
PDOLDATALEN = len(PDOLDATA) / 2
GPO = '80a80000' + "%02x" % PDOLDATALEN + PDOLDATA
A.APDU(GPO)

_log.debug("【==================== 读取应用数据 ======================】: ")
# ;取出AIP和AFL
AIP = COPY(A.RecvData, 3, 2)
AllLen = len(A.RecvData) / 2
AFLLen = AllLen - 4
AFL = COPY(A.RecvData, 5, AFLLen)

# ;**********读取应用数据**********
NULL = ''
TagCardData = ''
RecordForSDA = ''
ValueCardData = []
# ;读取包含数据的文件记录
# ;每一个文件,P2
# ;tag NextFile
while (AFL != ''):
    FileID = COPY(AFL, 1, 1)
    CursorForRecordInFile = COPY(AFL, 2, 1)
    EndRecordID = COPY(AFL, 3, 1)
    IsUsedInSDA = COPY(AFL, 4, 1)
    num = int(IsUsedInSDA, 16)
    P2 = int(FileID, 16) + 4
    # ;每一条记录,P1
    P1 = int(CursorForRecordInFile, 16)
    while (P1 <= int(EndRecordID, 16)):
        APDU = '00B2' + '%02X' % P1 + '%02X' % P2 + '00'
        A.APDU(APDU, '9000')
        Is81 = COPYCHAR(A.RecvData, 3, 2)
        NoTopHead = DELETECHAR(A.RecvData, 1, 4)
        if (Is81 == '81'):
            NoTopHead = DELETECHAR(NoTopHead, 1, 2)
        if (num != 0):
            RecordForSDA += NoTopHead
            num -= 1
        while (NoTopHead != ''):
            curTag, curValue, NoTopHead = GetFirstTLV(NoTopHead)
            TagCardData += curTag + '|'
            ValueCardData.append(curValue)
        P1 += 1
    AFL = DELETECHAR(AFL, 1, 8)
_log.debug("【==================== 脱机数据认证 ======================】: ")
# ;**********脱机数据认证************
# ;根据CA公钥索引，确定认证中心公钥
ret, IndexOfTag = which(TagCardData, '8F')
IndexOfTag = int(IndexOfTag, 16)
VAL_8F = ValueCardData[IndexOfTag - 1]
ret, NCANUM = which(FS8, VAL_8F)
NCANUM = int(NCANUM, 16)
NCA = NCAS[NCANUM - 1]
E = ECAS[NCANUM - 1]

# ;SDA静态数据认证

# ;从发卡行公钥证书恢复数据
ret, IndexOfTag = which(TagCardData, '90')
IndexOfTag = int(IndexOfTag, 16)
VAL_90 = ValueCardData[IndexOfTag - 1]
ret, IndexOfTag = which(TagCardData, '92')
IndexOfTag = int(IndexOfTag, 16)
VAL_92 = ValueCardData[IndexOfTag - 1]

N = NCA
SRC = VAL_90
ret, RESULT = RSA(N, E, SRC)
RESULT = DELETECHAR(RESULT, 1, 30)
RESULTLen = len(RESULT) / 2
NIPartLen = RESULTLen - 21
NIPart = COPY(RESULT, 1, NIPartLen)
NI = NIPart + VAL_92

# ;从签名的静态应用数据恢复数据
ret, IndexOfTag = which(TagCardData, '9F32')
IndexOfTag = int(IndexOfTag, 16)
VAL_9F32 = ValueCardData[IndexOfTag - 1]
ret, IndexOfTag = which(TagCardData, '93')
IndexOfTag = int(IndexOfTag, 16)
VAL_93 = ValueCardData[IndexOfTag - 1]

# ;7C00
N = NI
E = VAL_9F32
SRC = VAL_93
ret, RESULT = RSA(N, E, SRC)
RESULTLEN = len(RESULT) / 2
LEN = RESULTLEN - 20
CardHash = COPY(RESULT, LEN, 20)
LEN = RESULTLEN - 22
HASHDATA = COPY(RESULT, 2, LEN)

ret, IndexOfTag = which(TagCardData, '9F4A')
IndexOfTag = int(IndexOfTag, 16)
VAL_9F4A = ValueCardData[IndexOfTag - 1]

# ;构造SDA签名数据源
m = 1
STATIC = HASHDATA + RecordForSDA
LEN = len(VAL_9F4A) / 2
if (LEN != 0 and VAL_9F4A == '82'):
    STATIC = STATIC + AIP

ret, CalcHash = SHA1(STATIC)
# if (CalcHash != CardHash):
#     _log.debug("【==================== 用例执行失败 ======================】: ")
#     raise Exception

# ;DDA动态数据认证
ret, IndexOfTag = which(TagCardData, '9F46')
IndexOfTag = int(IndexOfTag, 16)
VAL_9F46 = ValueCardData[IndexOfTag - 1]
ret, IndexOfTag = which(TagCardData, '9F47')
IndexOfTag = int(IndexOfTag, 16)
VAL_9F47 = ValueCardData[IndexOfTag - 1]
ret, IndexOfTag1 = which(TagCardData, '9F48')
IndexOfTag1 = int(IndexOfTag1, 16)
if (IndexOfTag1 != 0):
    VAL_9F48 = ValueCardData[IndexOfTag1 - 1]

# ;从IC卡公钥证书恢复数据
N = NI
E = VAL_9F32
SRC = VAL_9F46
ret, RESULT = RSA(N, E, SRC)
RESULTLEN = len(RESULT) / 2
LEN = RESULTLEN - 20
CardHash = COPY(RESULT, LEN, 20)
LEN = RESULTLEN - 22
HASHDATA = COPY(RESULT, 2, LEN)

# ;7C00
if (IndexOfTag1 != 0):
    StaticPart = HASHDATA + VAL_9F48 + VAL_9F47
else:
    StaticPart = HASHDATA + VAL_9F47

# ;构造IC卡公钥证书签名数据源
m = 1
STATIC = StaticPart + RecordForSDA
LEN = len(VAL_9F4A) / 2
if (LEN != 0 and VAL_9F4A == '82'):
    STATIC = STATIC + AIP

ret, CalcHash = SHA1(STATIC)
# if (CalcHash != CardHash):
#     _log.debug("【==================== 用例执行失败 ======================】: ")
#     raise Exception

# ;获得IC卡公钥
RESULT = DELETECHAR(RESULT, 1, 42)
RESULTLEN = len(RESULT) / 2
NICQLEN = RESULTLEN - 21
NICQ = COPY(RESULT, 1, NICQLEN)

while (True):
    NICQLEN = len(NICQ) / 2
    BBFIRPOS = NICQLEN - 1
    BB = COPY(NICQ, BBFIRPOS, 1)
    if (BB != 'BB'):
        NICQ = COPY(NICQ, 1, BBFIRPOS)
        break
    NICQ = COPY(NICQ, 1, BBFIRPOS)

if (IndexOfTag1 != 0):
    NIC = NICQ + VAL_9F48
else:
    NIC = NICQ

# ;内部认证
TerRandNum = '55667788'

APDU = '0088000004' + TerRandNum
A.APDU(APDU, '9000')
IS81 = COPYCHAR(A.RecvData, 3, 2)
INERDATA = DELETECHAR(A.RecvData, 1, 4)
if (IS81 == '81'):
    INERDATA = DELETECHAR(INERDATA, 1, 2)

# ;从签名的动态应用数据恢复数据
N = NIC
E = VAL_9F47
SRC = INERDATA
ret, RESULT = RSA(N, E, SRC)
RESULTLEN = len(RESULT) / 2
RESULTLEN = len(RESULT) / 2
HASHDATASRC1LEN = RESULTLEN - 22
HASHDATASRC1 = COPY(RESULT, 2, HASHDATASRC1LEN)
HASHDATAPOS = RESULTLEN - 20
CardHash = COPY(RESULT, HASHDATAPOS, 20)

HASHDATA = HASHDATASRC1 + TerRandNum

ret, calcsha = SHA1(HASHDATA)
# if (calcsha != CardHash):
#     _log.debug("【==================== 用例执行失败 ======================】: ")
#     raise Exception
_log.debug("【==================== 终端行为分析 ======================】: ")
# ;////GAC1
ret, IndexOfTag = which(TagCardData, '8C')
IndexOfTag = int(IndexOfTag, 16)
CDol1 = ValueCardData[IndexOfTag - 1]

# ;组装GAC1数据
ret, gac1Data = LinkValueByTag(tags, valfortags, CDol1)
gac1DataLen = len(gac1Data) / 2
APDU = '80ae8000' + '%02X' % gac1DataLen + gac1Data
A.APDU(APDU, '9000')

# ;验证GAC1的结果
GacCardRtv = A.RecvData
CID = COPY(GacCardRtv, 3, 1)
ATC = COPY(GacCardRtv, 4, 2)
CVR = COPY(GacCardRtv, 17, 4)
CardRtvAC = COPY(GacCardRtv, 6, 8)

# ;验证ARQC
if (CID != '80'):
    _log.debug("【==================== 用例执行失败 ======================】: ")
    raise Exception
Dl = '000000000000' + ATC
toDr = int(ATC, 16) ^ 0XFFFF
Dr = '000000000000' + '%04X' % toDr
ret, SLKac = F_3DES(UDK_AC, Dl, 'ENC', 'CBC', '00', '0000000000000000')
ret, SRKac = F_3DES(UDK_AC, Dr, 'ENC', 'CBC', '00', '0000000000000000')
UDK_AC_Skey = SLKac + SRKac

ACDol = '9F02069F03069F1A0295055F2A029A039C019F3704'
ret, ARQCTerData = LinkValueByTag(tags, valfortags, ACDol)
dataARQC = ARQCTerData + AIP + ATC + CVR
ret, calcAC = Dmac_8(UDK_AC_Skey, dataARQC, '0000000000000000')
if (calcAC != CardRtvAC):
    _log.debug("【==================== 用例执行失败 ======================】: ")
    raise Exception

# ;MAC验证RightCOPY
LEN = len(GacCardRtv) / 2
if (LEN != 21):
    mac = COPY(GacCardRtv, LEN - 3, 4)
    IDDAllLen = COPY(GacCardRtv, 22, 1)
    IDDAllLen = int(IDDAllLen, 16)
    IDDAllLen -= 5
    IDDData = COPY(GacCardRtv, 24, IDDAllLen)
    src = ATC + IDDData + '00'
    LEN = len(src) / 2
    if (LEN != 8):
        src = ATC + IDDData + '00000000'

    Dl = '000000000000' + ATC
    toDr = int(ATC, 16) ^ 0XFFFF
    Dr = '000000000000' + '%04X' % toDr
    ret, SLKmac = F_3DES(UDK_MAC, Dl, 'ENC', 'CBC', '00', '0000000000000000')
    ret, SRKmac = F_3DES(UDK_MAC, Dr, 'ENC', 'CBC', '00', '0000000000000000')
    SKmac = SLKmac + SRKmac
    # ;计算MAC
    ret, calcMAC = Dmac_8(SKmac, src, '0000000000000000')
    calcMAC4 = COPY(calcMAC, 1, 4)
    if (mac != calcMAC4):
        _log.debug("【==================== 用例执行失败 ======================】: ")
        raise Exception

# ;计算ARPC,卡进行外部认证
# ;发卡行提供授权响应码 $ARC=2字节（3030）
ARC = '3030'
ARC1 = ARC + '000000000000'
dataInARPC16 = int(CardRtvAC, 16) ^ int(ARC1, 16)
dataInARPC = "%016X" % dataInARPC16
ret, ARPC = F_3DES(UDK_AC_Skey, dataInARPC, "ENC", "CBC", "00", "0000000000000000")
APDU = "008200000A" + ARPC + ARC
A.APDU(APDU, '9000')
_log.debug("【==================== 卡片行为分析 ======================】: ")
# ;////GAC2
ret, IndexOfTag = which(TagCardData, '8D')
IndexOfTag = int(IndexOfTag, 16)
CDol2 = ValueCardData[IndexOfTag - 1]
ret, gac2Data = LinkValueByTag(tags, valfortags, CDol2)
gac2DataLen = len(gac2Data) / 2
APDU = '80ae4000' + '%02x' % gac2DataLen + gac2Data
A.APDU(APDU, '9000')

# ;验证GAC2的结果
GacCardRtv = A.RecvData
CID = COPY(GacCardRtv, 3, 1)
ATC = COPY(GacCardRtv, 4, 2)
CVR = COPY(GacCardRtv, 17, 4)
CardRtvAC1 = COPY(GacCardRtv, 6, 8)

# ;验证TC
if (CID != '40'):
    _log.debug("【==================== 用例执行失败 ======================】: ")
    raise Exception

Dl = '000000000000' + ATC
toDr = int(ATC, 16) ^ 0XFFFF
Dr = '000000000000' + '%04X' % toDr
ret, SLKac = F_3DES(UDK_AC, Dl, 'ENC', 'CBC', '00', '0000000000000000')
ret, SRKac = F_3DES(UDK_AC, Dr, 'ENC', 'CBC', '00', '0000000000000000')
UDK_AC_Skey = SLKac + SRKac

ret, ARQCTerData = LinkValueByTag(tags, valfortags, ACDol)
dataARQC = ARQCTerData + AIP + ATC + CVR
ret, calcTC = Dmac_8(UDK_AC_Skey, dataARQC, '0000000000000000')
if (calcTC != CardRtvAC1):
    _log.debug("【==================== 用例执行失败 ======================】: ")
    raise Exception

# ;MAC验证
LEN = len(GacCardRtv) / 2
if (LEN != 21):
    mac = COPY(GacCardRtv, LEN - 3, 4)
    IDDAllLen = COPY(GacCardRtv, 22, 1)
    IDDAllLen = int(IDDAllLen, 16)
    IDDAllLen -= 5
    IDDData = COPY(GacCardRtv, 24, IDDAllLen)
    src = ATC + IDDData + '00'
    LEN = len(src) / 2
    if (LEN != 8):
        src = ATC + IDDData + '00000000'

    Dl = '000000000000' + ATC
    toDr = int(ATC, 16) ^ 0XFFFF
    Dr = '000000000000' + '%04X' % toDr
    ret, SLKmac = F_3DES(UDK_MAC, Dl, 'ENC', 'CBC', '00', '0000000000000000')
    ret, SRKmac = F_3DES(UDK_MAC, Dr, 'ENC', 'CBC', '00', '0000000000000000')
    SKmac = SLKmac + SRKmac
    # ;计算MAC
    ret, calcMAC = Dmac_8(SKmac, src, '0000000000000000')
    calcMAC4 = COPY(calcMAC, 1, 4)
    if (mac != calcMAC4):
        _log.debug("【==================== 用例执行失败 ======================】: ")
        raise Exception
_log.debug("【==================== 发卡行脚本处理 ======================】: ")
# ;电子现金充值
# ;获得ATC
APDU = '80ca9f3605'
A.APDU(APDU, '9000')

ATC = COPY(A.RecvData, 4, 5)
# ;新的余额
NewBalance = '000000050000'
Dl = '000000000000' + ATC
toDr = int(ATC, 16) ^ 0XFFFF
Dr = '000000000000' + '%04X' % toDr
ret, SLKmac = F_3DES(UDK_MAC, Dl, 'ENC', 'CBC', '00', '0000000000000000')
ret, SRKmac = F_3DES(UDK_MAC, Dr, 'ENC', 'CBC', '00', '0000000000000000')
SKmac = SLKmac + SRKmac
MACIn = '04DA9F790A' + ATC + CardRtvAC + NewBalance
# ;计算MAC
ret, calcMAC = Dmac_8(SKmac, MACIn, '0000000000000000')
MAC = COPY(calcMAC, 1, 4)
# ;修改余额（put data）
APDU = '04DA9F790A' + NewBalance + MAC
A.APDU(APDU, '9000')

# ;获得电子现金余额
APDU = '80ca9f7909'
A.APDU(APDU, '9000')
if (A.RecvData != '9F7906000000050000'):
    _log.debug("【==================== 用例执行失败 ======================】: ")
    raise Exception

del ValueCardData
_log.debug("【==================== 用例执行成功 ======================】: ")