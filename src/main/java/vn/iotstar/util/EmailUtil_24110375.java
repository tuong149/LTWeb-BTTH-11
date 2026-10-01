package vn.iotstar.util;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.Random;

public class EmailUtil_24110375 {
    
    public static String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }

    public static boolean sendOTP(String toEmail, String otpCode) {
        final String fromEmail = ConfigLoader_24110375.get("SMTP_USER");
        final String password = ConfigLoader_24110375.get("SMTP_PASSWORD");

        Properties props = new Properties();
        props.put("mail.smtp.host", ConfigLoader_24110375.get("SMTP_HOST"));
        props.put("mail.smtp.port", ConfigLoader_24110375.get("SMTP_PORT"));
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Mã OTP Xác Nhận Đăng Ký");
            message.setText("Chào bạn,\n\nMã OTP của bạn là: " + otpCode + "\nMã này dùng để xác thực tài khoản. Vui lòng không chia sẻ cho người khác.\n\nTrân trọng.");

            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
}

