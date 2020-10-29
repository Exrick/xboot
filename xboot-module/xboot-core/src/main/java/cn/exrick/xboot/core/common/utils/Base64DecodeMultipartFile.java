package cn.exrick.xboot.core.common.utils;

import cn.hutool.core.util.IdUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.Base64;
import java.util.Base64.Decoder;

/**
 * base64转为multipartFile工具类
 * @author Exrickx
 */
@Slf4j
public class Base64DecodeMultipartFile implements MultipartFile {

    private final byte[] imgContent;
    private final String header;

    public Base64DecodeMultipartFile(byte[] imgContent, String header) {
        this.imgContent = imgContent;
        this.header = header.split(";")[0];
    }

    @Override
    public String getName() {
        return IdUtil.simpleUUID() + "." + header.split("/")[1];
    }

    @Override
    public String getOriginalFilename() {
        return IdUtil.simpleUUID() + "." + header.split("/")[1];
    }

    @Override
    public String getContentType() {
        return header.split(":")[1];
    }

    @Override
    public boolean isEmpty() {
        return imgContent == null || imgContent.length == 0;
    }

    @Override
    public long getSize() {
        return imgContent.length;
    }

    @Override
    public byte[] getBytes() throws IOException {
        return imgContent;
    }

    @Override
    public InputStream getInputStream() throws IOException {
        return new ByteArrayInputStream(imgContent);
    }

    @Override
    public void transferTo(File dest) throws IOException, IllegalStateException {

        try (FileOutputStream fos = new FileOutputStream(dest)) {
            fos.write(imgContent);
        } catch (Exception e) {
            log.error(e.toString());
        }
    }

    public static MultipartFile base64Convert(String base64) {

        String[] baseStrs = base64.split(",");
        Decoder decoder = Base64.getDecoder();
        byte[] b = decoder.decode(baseStrs[1]);

        for (int i = 0; i < b.length; ++i) {
            if (b[i] < 0) {
                b[i] += 256;
            }
        }
        return new Base64DecodeMultipartFile(b, baseStrs[0]);
    }
}

