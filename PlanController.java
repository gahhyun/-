package com.ottt.ottt.controller.plan;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ottt.ottt.dao.login.LoginUserDao;
import com.ottt.ottt.dto.PlanDTO;
import com.ottt.ottt.dto.UserDTO;
import com.ottt.ottt.service.plan.PlanServiceImpl;

@Controller
@RequestMapping(value = "/plan")
public class PlanController {

	@Autowired
	PlanServiceImpl planService;
	@Autowired
	LoginUserDao loginUserDao;
	
	private static final Logger logger = LoggerFactory.getLogger(PlanController.class);

	
	  @GetMapping("/planList") 
	  public String planList(Integer user_no, HttpSession session, Model m) throws Exception{

		  try {
			  
			  List<PlanDTO> planList = planService.planList(user_no);
			  m.addAttribute("planList", planList);
			  
			  if(session.getAttribute("id") !=null) { 
				  UserDTO userDTO = loginUserDao.select((String) session.getAttribute("id"));
				  m.addAttribute("userDTO", userDTO); }
			
		  } catch  (Exception e) {e.printStackTrace();}

			  return "plan/planList"; 
	  }
	  
		//일정 목록 조회  ajax로 목록 가져오기...
    @ResponseBody
    @GetMapping("/getPlanList")
    public List<PlanDTO> getPlanList(HttpSession session) throws Exception{
    	
    	logger.info("/plan/getPlanList >>>>>> 호출 ");
		UserDTO userDTO = loginUserDao.select((String)session.getAttribute("id"));
		Integer no = userDTO.getUser_no();
		return planService.planList(no);
    	
    }
    
    
    @ResponseBody
    @PostMapping("/insertPlan")
    public Map<String, Object> insertPlan(PlanDTO planDTO, HttpSession session) throws Exception{
    	
		logger.info("/plan/insertPlan >>>>>> 호출 ");
		logger.info("planDTO>>>>>>>>>>> : "+planDTO.toString());
		
		Map<String, Object> result = new HashMap<String,Object>();
		
		UserDTO userDTO = loginUserDao.select((String)session.getAttribute("id"));
		if(userDTO != null) {
			 try {
		            planDTO.setUser_no(userDTO.getUser_no());
		            
		            // PlanDTO를 사용하여 서비스 계층에 일정을 삽입
		            if (planService.insertPlan(planDTO) > 0) {
		                result.put("result", 1);
		            } else {
		                result.put("result", 0);
		            }
		        } catch (ParseException e) {
		            e.printStackTrace();
		            result.put("result", 0);
		        }
		    } else {
		        logger.info("로그인이 필요합니다.");    // 추후 예외처리
		        result.put("result", 0);
		    }

		    return result;
		}
	
    
  /*  @ResponseBody
    @PostMapping("/insertPlan")
    public Map<String, Object> insertPlan(String plan_date, String plan_content, HttpSession session) throws Exception {
        logger.info("/plan/insertPlan >>>>>> 호출 ");

        Map<String, Object> result = new HashMap<String, Object>();

        UserDTO userDTO = loginUserDao.select((String) session.getAttribute("id"));
        if (userDTO != null) {
            PlanDTO planDTO = new PlanDTO();
            planDTO.setUser_no(userDTO.getUser_no());
            planDTO.setPlan_date(plan_date);
            planDTO.setPlan_content(plan_content);

            if (planService.insertPlan(planDTO) > 0) {
                result.put("result", 1);
            } else {
                result.put("result", 0);
            }
        } else {
            logger.info("로그인이 필요합니다."); // 추후 예외처리
        }

        return result;
    }
	  	
	  	*/

}
