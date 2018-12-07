package transform.edgeportal.bi.portal.bs;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;


/**
 * @author
 */
public class AutodeckImportTemplateServlet {
	private static Logger log = Logger.getLogger(AutodeckImportTemplateServlet.class);
	// private static String TEMPLATE_PATH = "/web/server_root/tmp/transform/edge/autodeck_config_file/";
	private static String	TEMPLATE_PATH		= null;
	private static int		SIZETHREDHOLD		= 1024 * 1024;																					// 1M
	private static int		SIZEMAX				= 5 * 1024 * 1024;																				// 5M
	private static int		CONFIGPPTCOLUMNSIZE	= 13;
	private static int		CONFIGXLSCOLUMNSIZE	= 12;
	private static String	ERROR_MSG			= "Your import is failed and you could take actions as below:<BR>"
														+ " (1) Follow the instruction in template to make sure you have proper format in the import file.<BR>"
														+ " (2) Please contact help desk if you cannot find any issue with the import file.";

	File					tempPathFile		= null;

	public String processImportFile(File savedFile, String output_type) {
		String json = "{\"MSG\": \"\",\"STATUS\": \"YES\"}";
		try {

			String fileName = null;
			String convert_id = null;
			// String savedFileName = null;
			// File savedFile = null;

			// TODO output type
			String outputType = output_type;
			// String json = "{\"MSG\": \"\",\"STATUS\": \"YES\"}";
			if (outputType.equals("2")) {
				// read and parse the configuration template file and convert to JSON
				List<ConfigPPTTemplateBean> list = parseConfigTemplatePPT(savedFile);
				if (list != null && list.size() > 0) {
					json = ConfigPPTTemplateBean.listToJson(list);
				}
			}

			if (outputType.equals("1") || outputType.equals("3")) {
				// read and parse the configuration template file and convert to JSON
				List<ConfigXLSTemplateBean> list = parseConfigTemplateXLS(savedFile);
				if (list != null && list.size() > 0) {
					json = ConfigXLSTemplateBean.listToJson(list);
					// System.out.println("the json is :"+json);
				}
			}
			// return JSON to UI
			//
			log.debug("the json is :" + json);
		} catch (Exception e) {
			log.error("ERROR:" + e.getMessage());
		} finally {

		}
		return json;
	}

	private void sendCreated(HttpServletResponse response, String json) {
		response.setStatus(200);
		response.setContentType("text/html;charset=UTF-8");
		StringBuilder body = new StringBuilder().append("<html>                                                 ")
				.append("  <boby>                                               ")
				.append("    <textarea>                                         ")
				.append(String.format("{status:201, message:'" + json + "'}"))
				.append("    </textarea>                                        ")
				.append("  </body>                                              ")
				.append("</html>                                                ");
		response.setContentLength(body.length());
		PrintWriter out;
		try {
			out = response.getWriter();
			out.print(body.toString());
			out.flush();
			out.close();
		} catch (IOException e) {
			log.error("ERROR:" + e.getMessage());
		}
	}

	private List<ConfigPPTTemplateBean> parseConfigTemplatePPT(File file) {
		List<ConfigPPTTemplateBean> list = new ArrayList<ConfigPPTTemplateBean>();
		try {
			// File file = new File(fileName);
			Workbook book = Workbook.getWorkbook(file);
			Sheet sheet = book.getSheet(0);
			// if(sheet.getColumns() != CONFIGPPTCOLUMNSIZE){
			// System.out.println("ERROR:Template Columns size is incorrect!");
			// ConfigPPTTemplateBean errorBean = new ConfigPPTTemplateBean();
			// errorBean.setError(true);
			// errorBean.setErrorMessage(ERROR_MSG);
			// list.add(errorBean);
			// return list;
			// }
			// read data from 3rd row
			for (int i = 2; i < sheet.getRows(); i++) {
				ConfigPPTTemplateBean ct = new ConfigPPTTemplateBean();
				for (int j = 0; j < CONFIGPPTCOLUMNSIZE; j++) {
					Cell cell = sheet.getCell(j, i);
					if (j == 0)
						ct.setRequest_id(cell.getContents());

					if (j == 1)
						ct.setSheet(cell.getContents());

					if (j == 2)
						ct.setRange(cell.getContents());

					if (j == 3)
						ct.setHide_rows(cell.getContents());

					if (j == 4)
						ct.setHide_columns(cell.getContents());

					if (j == 5)
						ct.setHeader_text(cell.getContents());

					if (j == 6)
						ct.setAutofit_rows(cell.getContents());

					if (j == 7)
						ct.setAutofit_columns(cell.getContents());

					if (j == 8)
						ct.setCustom_column_width(cell.getContents());

					if (j == 9)
						ct.setCustom_row_height(cell.getContents());

					if (j == 10)
						ct.setWrap_text_rows(cell.getContents());

					if (j == 11)
						ct.setDisplay_gridline(cell.getContents());

					if (j == 12)
						ct.setSlide(cell.getContents());

				}
				// check if it is a empty row in config file
				if (!ct.isEmptyObj())
					list.add(ct);
			}
		} catch (Exception e) {
	log.error("ERROR:parseConfigTemplatePPT()." + e.getMessage());
			e.printStackTrace();

			ConfigPPTTemplateBean errorBean = new ConfigPPTTemplateBean();
			errorBean.setError(true);
			errorBean.setErrorMessage(ERROR_MSG);
			list.add(errorBean);
			return list;

		}

		return list;
	}

	private List<ConfigXLSTemplateBean> parseConfigTemplateXLS(File file) {
		List<ConfigXLSTemplateBean> list = new ArrayList<ConfigXLSTemplateBean>();
		try {
			// File file = new File(fileName);
			Workbook book = Workbook.getWorkbook(file);
			Sheet sheet = book.getSheet(0);
			// if(sheet.getColumns() != CONFIGXLSCOLUMNSIZE){
			// System.out.println("ERROR:Template Columns size is incorrect!");
			// ConfigXLSTemplateBean errorBean = new ConfigXLSTemplateBean();
			// errorBean.setError(true);
			// errorBean.setErrorMessage(ERROR_MSG);
			// list.add(errorBean);
			// return list;
			// }
			// read data from 3rd row
			for (int i = 2; i < sheet.getRows(); i++) {
				ConfigXLSTemplateBean ct = new ConfigXLSTemplateBean();
				for (int j = 0; j < CONFIGXLSCOLUMNSIZE; j++) {
					Cell cell = sheet.getCell(j, i);
					if (j == 0)
						ct.setRequest_id(cell.getContents());

					if (j == 1)
						ct.setSheet(cell.getContents());

					if (j == 2)
						ct.setNew_sheet(cell.getContents());

					if (j == 3)
						ct.setRange(cell.getContents());

					if (j == 4)
						ct.setHide_rows(cell.getContents());

					if (j == 5)
						ct.setHide_columns(cell.getContents());

					if (j == 6)
						ct.setAutofit_rows(cell.getContents());

					if (j == 7)
						ct.setAutofit_columns(cell.getContents());

					if (j == 8)
						ct.setCustom_column_width(cell.getContents());

					if (j == 9)
						ct.setCustom_row_height(cell.getContents());

					if (j == 10)
						ct.setWrap_text_rows(cell.getContents());

					if (j == 11)
						ct.setDisplay_gridline(cell.getContents());

				}
				// check if it is a empty row in config file
				if (!ct.isEmptyObj())
					list.add(ct);
			}
		} catch (Exception e) {
			log.error("ERROR:parseConfigTemplateXLS()." + e.getMessage());
			e.printStackTrace();

			ConfigXLSTemplateBean errorBean = new ConfigXLSTemplateBean();
			errorBean.setError(true);
			errorBean.setErrorMessage(ERROR_MSG);
			list.add(errorBean);
			return list;
		}

		return list;
	}
}
