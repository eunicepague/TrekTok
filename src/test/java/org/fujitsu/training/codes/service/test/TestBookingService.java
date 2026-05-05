package org.fujitsu.training.codes.service.test;

import static org.junit.jupiter.api.Assertions.assertEquals; // Checks if expected and actual values are equal
import static org.junit.jupiter.api.Assertions.assertNotNull; // Checks if value is not null
import static org.junit.jupiter.api.Assertions.assertTrue; // Checks if condition is true
import static org.mockito.Mockito.when; // Used for mocking return values

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.fujitsu.training.codes.dao.BookingMapper;
import org.fujitsu.training.codes.model.data.Booking;
import org.fujitsu.training.codes.service.BookingService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class) // Enables Mockito in JUnit 5
public class TestBookingService {

    @Mock
    private SqlSessionFactory ssf; // Mocked SqlSessionFactory

    @Mock
    private SqlSession sess; // Mocked SqlSession

    @Mock
    private BookingMapper repo; // Mocked BookingMapper

    @InjectMocks
    private BookingService service; // Service under test with mocks injected

    @BeforeEach
    public void setup() {
        when(ssf.openSession()).thenReturn(sess); // When service opens session, return mocked session
        when(sess.getMapper(BookingMapper.class)).thenReturn(repo); // When session gets mapper, return mocked repo
    }

    @Test
    public void testCreateBookingSuccess() {
        when(repo.insertBooking(1, 1, 1, "sample comment", "2026-04-20")).thenReturn(1); // Mock successful insert

        boolean result = service.createBooking(1, 1, 1, "sample comment", "2026-04-20"); // Calls service method

        assertTrue(result); // Expects booking creation to be successful
    }

    @Test
    public void testSelectBookingsByUserId() {
        List<Booking> records = new ArrayList<>(); // Sample booking list
        records.add(new Booking()); // Adds one sample booking object

        when(repo.selectBookingsByUserId(1)).thenReturn(records); // Mock booking list for userId 1

        List<Booking> result = service.selectBookingsByUserId(1); // Calls service method

        assertNotNull(result); // Expects result list not to be null
        assertEquals(1, result.size()); // Expects one record in result
    }

    @Test
    public void testSelectAllBookings() {
        List<Booking> records = new ArrayList<>(); // Sample booking list
        records.add(new Booking()); // Adds one sample booking object

        when(repo.selectAllBookings()).thenReturn(records); // Mock all bookings result

        List<Booking> result = service.selectAllBookings(); // Calls service method

        assertNotNull(result); // Expects result list not to be null
        assertEquals(1, result.size()); // Expects one record in result
    }

    @Test
    public void testCancelBookingSuccess() {
        when(repo.cancelBooking(1)).thenReturn(1); // Mock successful cancel update

        boolean result = service.cancelBooking(1); // Calls service method

        assertTrue(result); // Expects cancel booking to be successful
    }
}