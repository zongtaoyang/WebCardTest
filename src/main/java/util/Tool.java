package util;

import java.util.UUID;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Tool {
    public String getUUID(int x) {
        UUID uuid = UUID.randomUUID();
        if (x == -1) return uuid.toString();
        else return uuid.toString().substring(0, x);
    }

    public String encodeMD5(String x) {
        StringBuffer md5Code = new StringBuffer();
        try {
            //获取加密方式为md5的算法对象
            MessageDigest instance = MessageDigest.getInstance("MD5");
            byte[] digest = instance.digest(x.getBytes());
            for (byte b : digest) {
                String hexString = Integer.toHexString(b & 0xff);
                if (hexString.length() < 2) {
                    hexString = "0" + hexString;
                }
                md5Code = md5Code.append(b);
            }
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return md5Code.toString();
    }
}
