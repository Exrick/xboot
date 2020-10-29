package xboot;

import com.aventstack.extentreports.testng.listener.ExtentITestListenerAdapter;
import org.testng.Assert;
import org.testng.annotations.Listeners;
import org.testng.annotations.Test;

@Listeners({ExtentITestListenerAdapter.class})
public class TestNGTest {

    @Test
    public void passTest() {
        Assert.assertTrue(true);
    }

}
