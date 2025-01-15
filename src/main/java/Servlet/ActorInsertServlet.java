package Servlet;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import BeansHome.Actor.*;


@WebServlet("/ActorInsertServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class ActorInsertServlet extends HttpServlet {

    private static final String SAVE_DIR = "D:\\Source\\photo";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 데이터 가져오기
        String actnoStr = request.getParameter("actno");
        String name = request.getParameter("name");
        Part photoPart = request.getPart("photo");
        
        System.out.println("actnoStr: " + actnoStr);
		System.out.println("name: " + name);
		

        // 파일 저장
        String photoName = photoPart.getSubmittedFileName();
        String photoPath = SAVE_DIR + File.separator + photoName;
        
        System.out.println("photoPart: " + photoPath);
        System.out.println("photoName: " + photoName);
        File saveDir = new File(SAVE_DIR);
        if (!saveDir.exists()) {
            saveDir.mkdirs();
        }
        photoPart.write(photoPath);

        // DTO 설정
        OldActorDTO actorDTO = new OldActorDTO();
        actorDTO.setActno(Integer.parseInt(actnoStr));
        actorDTO.setName(name);
        actorDTO.setPhoto("images/photo/" + photoName);

        // DAO 호출
        OldActorDAO actorDAO = new OldActorDAO();
        boolean result = false;
        String resultMessage;
        try {
            result = actorDAO.insertActor(actorDTO);
            resultMessage = result ? "배우 등록 성공!" : "배우 등록 실패!";
        } catch (Exception e) {
            e.printStackTrace();
            resultMessage = "오류 발생: " + e.getMessage();
        }

        // 결과 메시지 JSP로 전달
        request.setAttribute("resultMessage", resultMessage);

        // JSP로 포워딩
        request.getRequestDispatcher("insertActor.jsp").forward(request, response);
    }
}
