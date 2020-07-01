package osf.spring.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import osf.spring.dao.ProductDAO;
import osf.spring.dto.OptionDTO;
import osf.spring.dto.ProductDTO;
import osf.spring.dto.ProductImgDTO;

@Service
public class ProductService {

	@Autowired
	private ProductDAO pdao;

	public List<ProductDTO> getProduct(){
		return pdao.getProduct();
	}

	public int productAdd(String pname,int price,String content,String category,String sysname) {
		return pdao.productAdd(pname, price, content, category,sysname);
	}



	public int getProductSequence() {
		return pdao.getProductSequence();
	}

	public void addImg(List<ProductImgDTO> pdto,int seq) {
		pdao.addImg(pdto,seq);
	}

	public ProductDTO productDetail(int pseq) {
		return pdao.productDetail(pseq);
	}

	public int addOption(List<OptionDTO> odto) throws InterruptedException {
		int result = 0;
		for(int i=0;i<odto.size();i++) {
			pdao.addOption(odto.get(i));
		}
		return result;
	}
	
	public int productDelete(int seq) {
		return pdao.productDelete(seq);
	}
	
	public List<String> getImg(int pseq) {
		return pdao.getImg(pseq);
	}

	public void modifyImg(List<ProductImgDTO> pdto, int seq) {	
		pdao.modifyImg(pdto,seq);
	}

	public void modifyOption(List<OptionDTO> odto,int seq) throws InterruptedException {
		pdao.deleteOption(seq);
		for(int i=0;i<odto.size();i++) {
			pdao.addOption(odto.get(i));
		}
	}

	public int productModify(int pseq,String pname, int price, String content, String category, String sysname) {
		return pdao.productModify(pseq,pname,price,content,category,sysname);
	}

	public List<OptionDTO> getOption(int pseq) {
		return pdao.getOption(pseq);
	}

}
