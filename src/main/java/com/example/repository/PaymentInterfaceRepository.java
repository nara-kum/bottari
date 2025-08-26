package com.example.repository;

import com.example.vo.PaymentVO;

public interface PaymentInterfaceRepository {
	PaymentVO getAddress(int product_no);
}
