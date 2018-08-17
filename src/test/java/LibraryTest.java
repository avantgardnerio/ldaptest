import org.junit.Assert;
import org.junit.Test;
import org.springframework.ldap.core.DirContextAdapter;
import org.springframework.ldap.core.LdapTemplate;
import org.springframework.ldap.core.support.DefaultDirObjectFactory;
import org.springframework.ldap.core.support.LdapContextSource;

public class LibraryTest {

    @Test
    public void testSomeLibraryMethod() {
        LdapContextSource lcs = new LdapContextSource();
        lcs.setUrl("ldap://127.0.0.1:389/");
        lcs.setUserDn("cn=admin,dc=dev,dc=local");
        lcs.setPassword("test");
        lcs.setDirObjectFactory(DefaultDirObjectFactory.class);
        lcs.afterPropertiesSet();
        LdapTemplate ldap = new LdapTemplate(lcs);
        Object obj = ldap.lookup("cn=admin,dc=dev,dc=local");
        String name = ((DirContextAdapter) obj).getStringAttribute("cn");
        Assert.assertEquals("admin", name);
    }
}
