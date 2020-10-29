package xboot;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

public class SelenuimTest {

    public static void main(String[] args) {

        WebDriver driver = new ChromeDriver();
        driver.get("https://www.baidu.com");
    }
}
