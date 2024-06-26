package com.good.board.qna;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import com.good.board.model.CommentDTO;
import com.good.board.repository.QnaBoardDAO;

@WebServlet("/user/comment/qnaaddcomment.do")
public class QnaAddComment extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/user/study/study.jsp");
		dispatcher.forward(req, resp);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// POST 요청을 처리하여 댓글을 추가하는 코드를 작성합니다.
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		String setQNA_CM_CONTENT = request.getParameter("content");
		String QNA_SEQ = request.getParameter("qna_seq");

		// 댓글을 데이터베이스에 추가하는 코드를 작성합니다.
		CommentDTO dto = new CommentDTO();
		QnaBoardDAO dao = new QnaBoardDAO();
		
		dto.setId(id);
		dto.setContent(setQNA_CM_CONTENT);
		dto.setBoard_seq(QNA_SEQ);
		

		int result = dao.addComment(dto); // 댓글을 데이터베이스에 추가합니다. 성공 1
	
		
		//방금작성한 댓글 가져오기
		CommentDTO dto2 = dao.getComment(QNA_SEQ);
		
		
		JSONObject obj = new JSONObject();
		obj.put("result", result);
		
		JSONObject subObj = new JSONObject();
		subObj.put("QNA_CM_SEQ",dto2.getCm_seq());
		subObj.put("QNA_CM_CONTENT", dto2.getContent());
		subObj.put("QNA_CM_REGDATE", dto2.getRegdate());
		subObj.put("QNA_SEQ", dto2.getBoard_seq());
		subObj.put("QNA_CM_BSEQ", dto2.getCm_bseq());
		subObj.put("ID", dto2.getId());
		subObj.put("NICKNAME", dto2.getNickname());
		
		obj.put("dto", subObj);
		response.setCharacterEncoding("UTF-8");

		response.setContentType("application/json");
		PrintWriter wr = response.getWriter();
		wr.print(obj);
		wr.close();
				
}

}