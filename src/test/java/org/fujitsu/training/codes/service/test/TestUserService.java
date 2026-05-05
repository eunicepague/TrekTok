package org.fujitsu.training.codes.service.test;

import static org.junit.jupiter.api.Assertions.assertEquals; // Checks if expected and actual values are equal
import static org.junit.jupiter.api.Assertions.assertNotNull; // Checks if value is not null
import static org.junit.jupiter.api.Assertions.assertTrue; // Checks if condition is true
import static org.mockito.Mockito.when; // Used to define mock behavior

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.fujitsu.training.codes.dao.UserMapper;
import org.fujitsu.training.codes.model.data.User;
import org.fujitsu.training.codes.service.UserService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class) // Enables Mockito in JUnit 5 tests
public class TestUserService {

    @Mock
    private SqlSessionFactory ssf; // Mocked SqlSessionFactory

    @Mock
    private SqlSession sess; // Mocked SqlSession

    @Mock
    private UserMapper repo; // Mocked UserMapper

    @InjectMocks
    private UserService service; // Service under test with mocks injected

    @BeforeEach
    public void setup() {
        when(ssf.openSession()).thenReturn(sess); // When service opens session, return mocked session
        when(sess.getMapper(UserMapper.class)).thenReturn(repo); // When session gets mapper, return mocked repo
    }

    @Test
    public void testLoginSuccess() {
        User rec = new User(); // Sample user object
        rec.setEmail("user@test.com");
        rec.setPassword("1234");
        rec.setIsVerified(true);
        rec.setAccountStatus("ACTIVE");

        when(repo.selectByEmail("user@test.com")).thenReturn(rec); // Mock user lookup by email

        User result = service.login("user@test.com", "1234"); // Calls service method

        assertNotNull(result); // Expects login result not to be null
    }

    @Test
    public void testRegisterSuccess() {
        when(repo.selectByEmail("user@test.com")).thenReturn(null); // Mock email not existing yet
        when(repo.insertUser("Juan", "Luna", "user@test.com", "1234", "09123456789", 
                org.mockito.ArgumentMatchers.anyString())).thenReturn(1); // Mock successful insert

        String result = service.register("Juan", "Luna", "user@test.com", "1234", "09123456789"); // Calls service method

        assertNotNull(result); // Expects verification code result not to be null
    }

    @Test
    public void testVerifyUserSuccess() {
        when(repo.verifyUser("user@test.com", "123456")).thenReturn(1); // Mock successful verification update

        boolean result = service.verifyUser("user@test.com", "123456"); // Calls service method

        assertTrue(result); // Expects verification to be successful
    }

    @Test
    public void testSelectAllUsers() {
        List<User> records = new ArrayList<>(); // Sample user list
        records.add(new User()); // Adds one sample user object

        when(repo.selectAllUsers()).thenReturn(records); // Mock all users result

        List<User> result = service.selectAllUsers(); // Calls service method

        assertNotNull(result); // Expects result list not to be null
        assertEquals(1, result.size()); // Expects one record in result
    }
}