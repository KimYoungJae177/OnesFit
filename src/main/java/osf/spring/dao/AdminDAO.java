package osf.spring.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import osf.spring.dto.BestProductDTO;
import osf.spring.dto.BuyListDTO;
import osf.spring.dto.MemberDTO;
import osf.spring.dto.OptionDTO;
import osf.spring.dto.ProductDTO;
import osf.spring.dto.ProductImgDTO;
import osf.spring.dto.QuestionDTO;
import osf.spring.statics.Statics;

@Repository
public class AdminDAO {

	@Autowired
	private SqlSessionTemplate mybatis;

	public List<MemberDTO> getMembers(){
		return mybatis.selectList("admin.getMembers");
	}
	
	public int memberDelete(String id) {
		return mybatis.delete("admin.memberDelete",id);
	}
	
	public int memberBlack(String id) {
		return mybatis.update("admin.memberBlack",id);
	}
	
	public void unBlack(String id) {
		mybatis.update("admin.unBlack",id);
	}
	
	public int updatePoint(String id,int point) {
		Map<String,String> param = new HashMap();
		param.put("id", id);
		param.put("point", ""+point);
		System.out.println(id+"/"+point);
		return mybatis.update("admin.updatePoint",param);
	}
	
	public List<ProductDTO> getProduct(){
		return mybatis.selectList("admin.getProduct");
	}

	public int productAdd(String pname,int price,String content, String category,String sysname) {
		Map<String,String> param = new HashMap();
		param.put("pname", pname);
		param.put("price", ""+price);
		param.put("content", content);
		param.put("category", category);
		param.put("img", sysname);
		return mybatis.insert("admin.addProduct",param);	
	}

	//	public int addOption(String[] size,String[] color) {
	//		
	//	}

	public int getProductSequence() {
		int num;
		try {
			num = mybatis.selectOne("admin.getSequence");
		}catch(Exception e) {
			num = 1000;
		}

		return num+1;
	}

	public void addImg(List<ProductImgDTO> pdto,int seq) {
		for(ProductImgDTO p : pdto) {
			Map<String,String> param = new HashMap();
			param.put("img_seq", ""+seq);
			param.put("oriName", p.getOriName());
			param.put("sysName", p.getSysName());
			mybatis.insert("admin.addImg",param);
		}
	}

	public ProductDTO productDetail(int pseq){
		return mybatis.selectOne("admin.productDetail",pseq);
	}

	public int addOption(OptionDTO odto) throws InterruptedException {
		int result = 0;

		result = mybatis.insert("admin.addOption",odto);
		return result;
	}
	
	public int productDelete(int seq) {
		return mybatis.delete("admin.productDelete",seq);
	}
	
	public List<String> getImg(int pseq) {
		return mybatis.selectList("admin.getImg",pseq);
	}

	public void modifyImg(List<ProductImgDTO> pdto, int seq) {
		mybatis.delete("admin.deleteImg",seq);
		for(ProductImgDTO p : pdto) {
			Map<String,String> param = new HashMap();
			param.put("img_seq", ""+seq);
			param.put("oriName", p.getOriName());
			param.put("sysName", p.getSysName());
			mybatis.insert("admin.addImg",param);
		}
	}
	
	public void deleteOption(int seq) {
		mybatis.delete("admin.deleteOption",seq);
	}

	public int productModify(int pseq,String pname, int price, String content, String category, String sysname) {
		Map<String,String> param = new HashMap();
		param.put("pseq", ""+pseq);
		param.put("pname", pname);
		param.put("price", ""+price);
		param.put("content", content);
		param.put("category", category);
		param.put("img", sysname);
		for(String key : param.keySet()) {
			System.out.println(param.get(key));
		}
		return mybatis.update("admin.productModify",param);
	}

	public List<OptionDTO> getOption(int pseq) {
		return mybatis.selectList("admin.getOption",pseq);
	}

	public List<Integer> getSales() {
		return mybatis.selectList("admin.getSales");
	}
	
	public int totalSale() {
		return mybatis.selectOne("admin.totalSale");
	}
	
	public List<BestProductDTO> itemRank(){
		return mybatis.selectList("admin.itemRank");
	}
	
	public ProductDTO bestProduct(int pseq){
		return mybatis.selectOne("admin.bestProduct",pseq);
	}

	public int setBest(int pseq) {
		
		return mybatis.update("admin.setBest",pseq);
	}
	
	public int unBest(int pseq) {
		return mybatis.update("admin.unBest",pseq);
	}
	
	/////////////////////영재씨파트 ////////////////////////////////
	//buyList
		public List<BuyListDTO> selectByPageNo(int page){
			int start = page * Statics.RECORD_COUNT_PER_PAGE - (Statics.RECORD_COUNT_PER_PAGE-1);
			int end = start + (Statics.RECORD_COUNT_PER_PAGE-1);
			Map<String, Integer> param = new HashMap<>();
			param.put("start",start);
			param.put("end", end);
			
			return mybatis.selectList("admin.selectList",param);
			
		}
		
		public int getArticleCount() {
			return mybatis.selectOne("admin.getArticleCount");
		}

		public Object updateWhenStatusN(Map<String, Object> updateParam) {
			return mybatis.update("admin.updateWhenStatusN", updateParam);
		}

		public Object updateWhenStatusY0(Map<String, Object> updateParam) {
			return mybatis.update("admin.updateWhenStatusY0", updateParam);
		}

		public Object updateWhenStatusYX(Map<String, Object> updateParam) {
			return mybatis.update("admin.updateWhenStatusYX", updateParam);
		}

		
		//Question
		public List<QuestionDTO> qSelectAll() {
			return mybatis.selectList("admin.qSelectAll");
		}

		public int getQuestionArticleCount() {
			return mybatis.selectOne("admin.getQuestionArticleCount");
		}

		public int answerInput(Map<String, Object> inputParam) {
			mybatis.update("admin.answerUpdate", inputParam);
			return mybatis.insert("admin.answerInput", inputParam);
		}

		public List<Integer> visit() {
			return mybatis.selectList("admin.visit");
		}

	
}
