package controller;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;

import static org.junit.Assert.assertEquals;

public class ValidateName {
    private PlaceOrderController placeOrderController;

    @BeforeEach
    void setUp() {
        placeOrderController = new PlaceOrderController();
    }

    @ParameterizedTest
    
    public void test(String name, boolean trueVal) {
        boolean boolVal = placeOrderController.validateName(name);
        assertEquals(trueVal, boolVal);
    }
}

