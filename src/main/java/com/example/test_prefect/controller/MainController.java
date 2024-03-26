package com.example.test_prefect.controller;

import com.example.test_prefect.model.BoardVO;
import com.example.test_prefect.service.BoardService;
import com.example.test_prefect.service.UserService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class MainController {
    final Logger LOG = LogManager.getLogger(getClass());

    @Autowired
    BoardService boardService;

    @Autowired
    UserService userService;


        @RequestMapping(value = "/")
        public String mainView (Model model, HttpSession httpsession) {

            String role = (String) httpsession.getAttribute("role");

            model.addAttribute("role", role);

            LOG.debug("role:" + role);

            int totalBoard = boardService.totalBoard();
            model.addAttribute("totalBoard", totalBoard);

            int totalUsers = userService.totalUsers();
            model.addAttribute("totalUsers", totalUsers);

            LOG.debug("┌───────────────────────────────────────────┐");
            LOG.debug("│ mainView                				   │");
            LOG.debug("└───────────────────────────────────────────┘");

            List<BoardVO> topBoards = boardService.totalBoardByReadCnt();
            model.addAttribute("topBoards", topBoards);

            return "main";
        }
}
