package com.example.service;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.repository.CartRepository;
import com.example.vo.CartListVO;
import com.example.vo.DetailOptionVO;
import com.example.vo.OptionVO;
import com.example.vo.ProductOptionListVO;
import com.example.vo.ProductionOptionVO;

@Service
public class CartService {
	// field
	@Autowired
	private CartRepository cartrepository;
	// editor

	// method g/s

	// method normal
	public List<CartListVO> exeAllinOne(int user_no) {
		System.out.println("CartService.exeAllinOne()");

		List<CartListVO> cartList = cartrepository.selectCartList(user_no);
		System.out.println("cartList: " + cartList);

		if (cartList.isEmpty()) {
			return cartList;
		} else {
			List<Integer> productNoList = cartList.stream().map(CartListVO::getProduct_no).collect(Collectors.toList());
			System.out.println(productNoList);

			List<ProductOptionListVO> productOptionList = cartrepository.selectByProductNoList(productNoList);
			System.out.println(productOptionList);

			// flat => nested 변환
			List<ProductionOptionVO> nestedOptions = convertToNested(productOptionList);
			System.out.println(nestedOptions);

			// product_no 기준으로 옵션 매핑
			Map<Integer, List<OptionVO>> optionMap = nestedOptions.stream()
					.collect(Collectors.toMap(ProductionOptionVO::getProduct_no, ProductionOptionVO::getOptions));

			// CartListVO에 옵션 세팅
			for (CartListVO cart : cartList) {
				cart.setOptions(optionMap.get(cart.getProduct_no()));
			}

			return cartList;
		}
	}

	private List<ProductionOptionVO> convertToNested(List<ProductOptionListVO> flatList) {
		System.out.println("CartService.convertToNested()");

		Map<Integer, ProductionOptionVO> productMap = new LinkedHashMap<>();

		for (ProductOptionListVO row : flatList) {
			// 상품 단위로 묶기
			productMap.putIfAbsent(row.getProduct_no(), new ProductionOptionVO());
			ProductionOptionVO product = productMap.get(row.getProduct_no());
			product.setProduct_no(row.getProduct_no());

			// 상품 안에서 option 단위로 묶기
			// option_no 기준 Map (상품 안에서만 해당)
			Map<Integer, OptionVO> optionMap = product.getOptions().stream()
					.collect(Collectors.toMap(OptionVO::getOption_no, o -> o));

			OptionVO option = optionMap.get(row.getOption_no());
			if (option == null) {
				option = new OptionVO();
				option.setOption_no(row.getOption_no());
				option.setOption_name(row.getOption_name());
				product.getOptions().add(option);
			}

			// detail 추가
			DetailOptionVO detail = new DetailOptionVO();
			detail.setDetailoption_no(row.getDetailoption_no());
			detail.setDetailoption_name(row.getDetailoption_name());

			option.getDetailList().add(detail);
		}
		return new ArrayList<>(productMap.values());
	}

	// 수량 업데이트
	public int exeupdateQuantity(int cartNo, int newQuantityValue) {
		System.out.println("CartService.updateQuantity()");

		int count = cartrepository.updateCartQuantity(cartNo, newQuantityValue);

		return count;
	}

	// 옵션 변경
	public int exeupdateOption(int cartNo, int optionNo) {
		System.out.println("CartService.exeupdateOption");

		int count = cartrepository.updateCartOptions(cartNo, optionNo);

		System.out.println("어헣 나 서비스로 내려와따");

		return count;
	}

	// 기념일 변경
	public int exeupdateAnniversary(int cartNo, int cartegory_no) {
		System.out.println("CartService.exeupdateAnniversary()");

		int count = cartrepository.updateCartAnniversary(cartNo, cartegory_no);

		return count;
	}

	// 장바구니 삭제
	public int exedeleteCartItem(int cart_no) {
		System.out.println("CartService.exedeleteCartItem()");

		int count = cartrepository.deleteCartItem(cart_no);

		return count;
	}

	// ✅ 다건 삭제
	public int exedeleteCartItems(List<Integer> cartNos) {
		System.out.println("CartService.exedeleteCartItems()");
		if (cartNos == null || cartNos.isEmpty())
			return 0;

		// cart_option 먼저 정리(제약조건 대비) → cart 삭제
		cartrepository.deleteCartOptionsByCartNos(cartNos);
		int count = cartrepository.deleteCartItems(cartNos);
		return count;
	}

}
