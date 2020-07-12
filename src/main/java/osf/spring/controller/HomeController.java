package osf.spring.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import osf.spring.dto.MemberDTO;
import osf.spring.dto.ProductDTO;
import osf.spring.service.ProductService;

@Controller
public class HomeController {
	
	@Autowired
	HttpSession session;
	
	@Autowired
	private ProductService pservice;
	
	@RequestMapping("/")
	public String home(Model model,String tab2) {
		List<ProductDTO> products = pservice.productSelectAll();
		
		if(session.getAttribute("loginInfo") == null) {
			session.invalidate();
			String a = "pzlogin";
			session.setAttribute("loginInfo", a);
			System.out.println(session.getAttribute("loginInfo"));
		}
		
		if(session.getAttribute("loginid") == null) {
			session.invalidate();
			session.setAttribute("loginid", "pzlogin");
			System.out.println("loginid : " + session.getAttribute("loginid")); 
		}
		
		List<ProductDTO> color = pservice.color();
		model.addAttribute("color",color);
		model.addAttribute("products", products);
		if(tab2 != "") {
		model.addAttribute("tab2", tab2);
		}else {
			tab2 = "";
			model.addAttribute("tab2",tab2);
		}
		return "index";
	}
	@RequestMapping("notice")
	public String notice() {
		return "notice/notice_list?page=1";
	}
	
}
