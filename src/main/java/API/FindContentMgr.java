// #################################################################################################
// FindContentMgr.java - 서블릿 이상형 월드컵 라운드 초기 설정 모듈 (DB에서 배우 정보 추출 + 리스트 생성 +  리스트 셔플 + Session 설정 + ServletRoundPlay 전송) 
// FindContentMgr.java - recommend.jsp API 처리 클래스 (API 키 관리 클래스 (ApiKeyManager), API 호출 + JSON 파싱 + GETTER) 
// #################################################################################################
// ═════════════════════════════════════════════════════════════════════════════════════════
// 외부모듈 영역
// ═════════════════════════════════════════════════════════════════════════════════════════
package API;

import java.io.IOException;
import java.util.Properties;
import java.net.URL;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
//═════════════════════════════════════════════════════════════════════════════════════════
// 사용자정의 클래스 영역
//═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
* ApiKeyManager			: API Key 관리 클래스
***********************************************************************/
class ApiKeyManager {
	/***********************************************************************
	 * getApiKey()		: apikey.properties 파일 가져옴
	 * @return String	: API Key 반환
	 * @exception IOException
	 ***********************************************************************/
	public String getApiKey() throws IOException {		
		Properties prop = new Properties();
		String propFile = "API/apikey.properties";
		
		URL props = getClass().getClassLoader().getResource(propFile);
		prop.load(props.openStream());
		
		String apiKey = prop.getProperty("TMDB_API_KEY");
	    
	    return apiKey;
	}
}

/***********************************************************************
* FindContentMgr			: TMDB 데이터 검색 클래스
***********************************************************************/
public class FindContentMgr
{
	private int Id;
	private String posterPath;
	private String mediaType;
	
	// 생성자 관리 - 필수영역(인스턴스함수)
 	// —————————————————————————————————————————————————————————————————————————————————————
 	/***********************************************************************
 	 * FindContentMgr(String query)		: 생성자
 	 * @param void							: None
 	 ***********************************************************************/
	public FindContentMgr(String query) {
		if (query != null && !query.trim().isEmpty()) {
	        try {
	        	// -----------------------------------------------------------------	
				// API Key 설정
				// -----------------------------------------------------------------
	        	ApiKeyManager key = new ApiKeyManager();
	        	String apiKey = key.getApiKey();
	        	

	        	int currentPage = 1; // 현재 페이지
	        	int totalPages = 1;	 // 전체 페이지 (초기값)
	        	
	        	// -----------------------------------------------------------------	
				// JSON 쿼리 페이지가 한 페이지에 다 나오지 않을 경우가 있기 때문에 전체 페이지 조회
				// -----------------------------------------------------------------
	        	while (currentPage <= totalPages) {
	        		String apiUrl = "https://api.themoviedb.org/3/search/multi?api_key=" + apiKey + "&query=" + java.net.URLEncoder.encode(query, "UTF-8") + "&language=ko-KR&page=" + currentPage;
		            java.net.URL url = new java.net.URL(apiUrl);
		            java.net.HttpURLConnection connection = (java.net.HttpURLConnection) url.openConnection();
		            connection.setRequestMethod("GET");
		            connection.setConnectTimeout(5000);
	                connection.setReadTimeout(5000);

	                try (java.io.BufferedReader reader = new java.io.BufferedReader(new java.io.InputStreamReader(connection.getInputStream(), "UTF-8"))) {
		                StringBuilder responseBuilder = new StringBuilder();
		                String line;
		                while ((line = reader.readLine()) != null) {
		                    responseBuilder.append(line);
		                }
			        	// -----------------------------------------------------------------	
						// JSON 형식 String -> JSONObject
						// -----------------------------------------------------------------
		                String response = responseBuilder.toString();
		                	
		                JSONParser parser = new JSONParser();
		                JSONObject json = (JSONObject) parser.parse(response);
		                
			        	// -----------------------------------------------------------------	
						// 초기에 한 번 total_pages 값 구하기
						// -----------------------------------------------------------------
		                if (currentPage == 1) {
		                	totalPages = ((Long) json.get("total_pages")).intValue();
		                }
		                
			        	// -----------------------------------------------------------------	
						// JSON 값 조회
						// -----------------------------------------------------------------
		                JSONArray results = (JSONArray) json.get("results");

		                for (Object obj : results) {
		                    JSONObject item = (JSONObject) obj;
							
		                    String originalLanguage = (String) item.get("original_language");
		                    if (!"ja".equals(originalLanguage)) continue;
		                    String title = (String) (item.get("title"));
		                    if (title == null) {
		                    	title = (String) (item.get("name"));
		                    }
		                    if (query.equals(title)) {
		                    	Id = Integer.parseInt(item.get("id").toString());
		                    	posterPath = (String) (item.get("poster_path"));
		                    	mediaType = (String) (item.get("media_type"));
		                        break; // 첫 번째 ID를 찾으면 반복문 종료
		                    }
		                }
		                currentPage++;  // 다음 페이지로 이동
		            }
	        	}
	        	
	        } catch (java.io.IOException e) {
	            System.err.println("Error with HTTP connection or protocol: " + e.getMessage());
	        } catch (ParseException e) {
	            System.err.println("Error parsing JSON: " + e.getMessage());
	        }
	    }
	}

	public int getId()
	{
		return Id;
	}

	public String getPosterPath()
	{
		return posterPath;
	}

	public String getMediaType()
	{
		return mediaType;
	}
}
