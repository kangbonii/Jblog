package com.javaex.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.service.JblogService;
import com.javaex.vo.BlogVo;
import com.javaex.vo.CategoryVo;
import com.javaex.vo.PostVo;
import com.javaex.vo.UserVo;

@Controller
@RequestMapping(value="/")
public class JblogController {
	
	@Autowired
	private JblogService jblogService;
	

	/*
	 * @RequestMapping(value="/main", method=RequestMethod.GET) public String
	 * main(@PathVariable("id") int id, Model model) { BlogVo blogvo return
	 * "blog/blog-main"; }
	 */
	
	@RequestMapping(value="/{id}", method=RequestMethod.GET)
	public String main(@PathVariable("id") String id,
					   @ModelAttribute CategoryVo CategoryVo,
					   @ModelAttribute PostVo PostVo,
						HttpSession session, Model model) {
		UserVo userVo = (UserVo) session.getAttribute("authUser");
		model.addAttribute("userVo", userVo);
		
		BlogVo selectedBlog = jblogService.getTitle(id);
		model.addAttribute("title", selectedBlog.getBlogTitle());
		model.addAttribute("BlogVo", selectedBlog);
		
		PostVo selectTitle = jblogService.getPost(id);
		System.out.println(selectTitle.toString());
		model.addAttribute("PostVo", selectTitle);
		
		List<PostVo> postList = jblogService.postList(id);
		System.out.println("################");
		System.out.println(postList);
		model.addAttribute("PostList", postList);
		
		List<CategoryVo> categoryVo = jblogService.readList(id);
		System.out.println(categoryVo.toString());
		model.addAttribute("categoryVo", categoryVo);
		
		return "blog/blog-main";
	}
	
	@RequestMapping(value="/{id}/admin/basic", method=RequestMethod.GET)
	public String user(@PathVariable("id") String id, 
			HttpSession session, Model model) {

		UserVo authUserVo = (UserVo) session.getAttribute("authUser");
		System.out.print(authUserVo);
		BlogVo selectedBlog = jblogService.getTitle(authUserVo.getId());
		System.out.print(selectedBlog.getBlogTitle());

		model.addAttribute("title", selectedBlog.getBlogTitle());
		model.addAttribute("BlogVo", selectedBlog);
		
		
		return "blog/admin/blog-admin-basic";
	}
	

	@RequestMapping(value="/{id}/admin/basic/update", method=RequestMethod.POST)
	public String update(@PathVariable("id") String id, 
					     @RequestParam ("file") MultipartFile file, 
						 @ModelAttribute BlogVo BlogVo, Model model) {
		/* jblogService.modify(BlogVo); */
		
		System.out.println(file.getOriginalFilename());
		BlogVo.setId(id);
		int count = jblogService.restore(file, BlogVo);
		System.out.println(count);
		return "redirect:/"+id+"/admin/basic";
	}
	
	@ResponseBody
	@RequestMapping(value="/{id}/admin/basic/category", method=RequestMethod.GET)
	public List<CategoryVo> category(@PathVariable("id") String id,@ModelAttribute CategoryVo CategoryVo,HttpSession session, Model model) {
		UserVo userVo = (UserVo) session.getAttribute("authUser");
		model.addAttribute("userVo", userVo);
		
		BlogVo selectedBlog = jblogService.getTitle(id);
		System.out.println("######################");
		model.addAttribute("title", selectedBlog.getBlogTitle());
		model.addAttribute("BlogVo", selectedBlog);
		
		List<CategoryVo> categoryList = jblogService.getList(id);
		System.out.println(categoryList);
		return categoryList; 
	}
	
	@ResponseBody
	@RequestMapping(value="/{id}/admin/basic/cateadd", method=RequestMethod.POST)
	public  CategoryVo cateadd(@PathVariable("id") String id,@ModelAttribute CategoryVo CategoryVo,HttpSession session) {
		//UserVo userVo = (UserVo) session.getAttribute("authUser");
		CategoryVo.setID(id);
		System.out.println(CategoryVo.toString());
		CategoryVo category = jblogService.addcate(CategoryVo);
		return category; 
	}
	
	@RequestMapping(value="/{id}/admin/cate", method=RequestMethod.GET)
	public String cate(@PathVariable("id") String id,@ModelAttribute CategoryVo CategoryVo,HttpSession session, Model model) {
		UserVo userVo = (UserVo) session.getAttribute("authUser");
		model.addAttribute("userVo", userVo);
		
		BlogVo selectedBlog = jblogService.getTitle(id);
		model.addAttribute("title", selectedBlog.getBlogTitle());
		model.addAttribute("BlogVo", selectedBlog);
		return "blog/admin/blog-admin-cate"; 
	}

	//
	@RequestMapping(value="/{id}/admin/basic/write", method=RequestMethod.GET)
	public String write(@PathVariable("id") String id, @ModelAttribute CategoryVo CategoryVo, HttpSession session, Model model) {
		UserVo userVo = (UserVo) session.getAttribute("authUser");
		model.addAttribute("userVo", userVo);
		
		BlogVo selectedBlog = jblogService.getTitle(id);
		model.addAttribute("title", selectedBlog.getBlogTitle());
		model.addAttribute("BlogVo", selectedBlog);
		
		List<CategoryVo> categoryVo = jblogService.readList(id);
		System.out.println(categoryVo.toString());
		model.addAttribute("categoryVo", categoryVo);
		
		return "blog/admin/blog-admin-write"; 
	}
	
	//글쓰기 
	@RequestMapping(value="/{id}/admin/basic/writeform", method=RequestMethod.POST)
	public String writeform(@PathVariable("id") String id,
							@ModelAttribute PostVo PostVo, 
							HttpSession session, Model model) {
		
		int count = jblogService.write(PostVo);
		System.out.print("글작성");
		System.out.println(count);
	
				

		return "redirect:/\"+id+\"/admin/basic"; 
	}
	
	@ResponseBody
	@RequestMapping(value = "/{id}/admin/basic/delete", method = RequestMethod.POST)
	public int delete(@ModelAttribute CategoryVo CategoryVo) {
		System.out.println("delete    "+CategoryVo.toString());
		

		int count =jblogService.delete(CategoryVo);
		System.out.println(count);
	
		return count; 

	}
	
	
	
	
	
	
}
