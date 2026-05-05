package org.fujitsu.training.codes.service.test;

import static org.junit.jupiter.api.Assertions.assertEquals; // Checks if expected and actual values are equal
import static org.junit.jupiter.api.Assertions.assertNotNull; // Checks if value is not null
import static org.junit.jupiter.api.Assertions.assertTrue; // Checks if condition is true
import static org.mockito.Mockito.when; // Used to define mock behavior

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.fujitsu.training.codes.dao.PaymentMapper;
import org.fujitsu.training.codes.model.data.Payment;
import org.fujitsu.training.codes.service.PaymentService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class) // Enables Mockito in JUnit 5 tests
public class TestPaymentService {

    @Mock
    private SqlSessionFactory ssf; // Mocked SqlSessionFactory

    @Mock
    private SqlSession sess; // Mocked SqlSession

    @Mock
    private PaymentMapper repo; // Mocked PaymentMapper

    @InjectMocks
    private PaymentService service; // Service under test with mocks injected

    @BeforeEach
    public void setup() {
        when(ssf.openSession()).thenReturn(sess); // When service opens session, return mocked session
        when(sess.getMapper(PaymentMapper.class)).thenReturn(repo); // When session gets mapper, return mocked repo
    }

    @Test
    public void testCreatePaymentSuccess() {
        when(repo.insertPayment(1, "Juan Luna", "1234567890123456", "CARD", 5000.00)).thenReturn(1); // Mock successful insert

        boolean result = service.createPayment(1, "Juan Luna", "1234567890123456", "CARD", 5000.00); // Calls service method

        assertTrue(result); // Expects payment creation to be successful
    }

    @Test
    public void testSelectPaymentByBookingId() {
        Payment rec = new Payment(); // Sample payment object

        when(repo.selectPaymentByBookingId(1)).thenReturn(rec); // Mock payment lookup by booking ID

        Payment result = service.selectPaymentByBookingId(1); // Calls service method

        assertNotNull(result); // Expects payment result not to be null
    }

    @Test
    public void testSelectAllPayments() {
        List<Payment> records = new ArrayList<>(); // Sample payment list
        records.add(new Payment()); // Adds one sample payment object

        when(repo.selectAllPayments()).thenReturn(records); // Mock all payments result

        List<Payment> result = service.selectAllPayments(); // Calls service method

        assertNotNull(result); // Expects result list not to be null
        assertEquals(1, result.size()); // Expects one record in result
    }

    @Test
    public void testIsBookingPaid() {
        Payment rec = new Payment(); // Sample payment object means booking is already paid

        when(repo.selectPaymentByBookingId(1)).thenReturn(rec); // Mock existing payment for booking ID 1

        boolean result = service.isBookingPaid(1); // Calls service method

        assertTrue(result); // Expects booking payment status to be true
    }
}