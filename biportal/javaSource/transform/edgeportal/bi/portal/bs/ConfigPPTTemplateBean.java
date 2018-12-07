/**
 * 
 */
package transform.edgeportal.bi.portal.bs;

import java.util.List;

/**
 * @author leo
 * 
 */
public class ConfigPPTTemplateBean {

	private String	request_id			= null;
	private String	sheet				= null;
	private String	range				= null;
	private String	hide_rows			= null;
	private String	hide_columns		= null;
	private String	header_text			= null;
	private String	autofit_rows		= null;
	private String	autofit_columns		= null;
	private String	custom_column_width	= null;
	private String	custom_row_height	= null;
	private String	wrap_text_rows		= null;
	private String	display_gridline	= null;
	private String	slide				= null;

	private boolean	isError				= false;
	private String	errorMessage		= null;

	public String getRequest_id() {
		return request_id;
	}

	public void setRequest_id(String request_id) {
		this.request_id = request_id;
	}

	public String getSheet() {
		return sheet;
	}

	public void setSheet(String sheet) {
		this.sheet = sheet;
	}

	public String getRange() {
		return range;
	}

	public void setRange(String range) {
		this.range = range;
	}

	public String getHide_rows() {
		return hide_rows;
	}

	public void setHide_rows(String hide_rows) {
		this.hide_rows = hide_rows;
	}

	public String getHeader_text() {
		return header_text;
	}

	public void setHeader_text(String header_text) {
		this.header_text = header_text;
	}

	public String getAutofit_rows() {
		return autofit_rows;
	}

	public void setAutofit_rows(String autofit_rows) {
		this.autofit_rows = autofit_rows;
	}

	public String getAutofit_columns() {
		return autofit_columns;
	}

	public void setAutofit_columns(String autofit_columns) {
		this.autofit_columns = autofit_columns;
	}

	public String getCustom_column_width() {
		return custom_column_width;
	}

	public void setCustom_column_width(String custom_column_width) {
		this.custom_column_width = custom_column_width;
	}

	public String getCustom_row_height() {
		return custom_row_height;
	}

	public void setCustom_row_height(String custom_row_height) {
		this.custom_row_height = custom_row_height;
	}

	public String getWrap_text_rows() {
		return wrap_text_rows;
	}

	public void setWrap_text_rows(String wrap_text_rows) {
		this.wrap_text_rows = wrap_text_rows;
	}

	public String getDisplay_gridline() {
		return display_gridline;
	}

	public void setDisplay_gridline(String display_gridline) {
		this.display_gridline = display_gridline;
	}

	public String getSlide() {
		return slide;
	}

	public void setSlide(String slide) {
		this.slide = slide;
	}

	public String getHide_columns() {
		return hide_columns;
	}

	public void setHide_columns(String hide_columns) {
		this.hide_columns = hide_columns;
	}

	public boolean isError() {
		return isError;
	}

	public void setError(boolean isError) {
		this.isError = isError;
	}

	public String getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}

	public static String beanToJson(ConfigPPTTemplateBean bean) {
		StringBuilder json = new StringBuilder();
		json.append("{");
		json.append("\"request_id\":");
		json.append("\"").append(bean.getRequest_id()).append("\",");

		json.append("\"sheet\":");
		json.append("\"").append(bean.getSheet()).append("\",");

		json.append("\"range\":");
		json.append("\"").append(bean.getRange()).append("\",");

		json.append("\"hide_rows\":");
		json.append("\"").append(bean.getHide_rows()).append("\",");

		json.append("\"hide_columns\":");
		json.append("\"").append(bean.getHide_columns()).append("\",");

		json.append("\"header_text\":");
		json.append("\"").append(bean.getHeader_text()).append("\",");

		json.append("\"autofit_rows\":");
		json.append("\"").append(bean.getAutofit_rows()).append("\",");

		json.append("\"autofit_columns\":");
		json.append("\"").append(bean.getAutofit_columns()).append("\",");

		json.append("\"custom_column_width\":");
		json.append("\"").append(bean.getCustom_column_width()).append("\",");

		json.append("\"custom_row_height\":");
		json.append("\"").append(bean.getCustom_row_height()).append("\",");

		json.append("\"wrap_text_rows\":");
		json.append("\"").append(bean.getWrap_text_rows()).append("\",");

		json.append("\"display_gridline\":");
		json.append("\"").append(bean.getDisplay_gridline()).append("\",");

		json.append("\"slide\":");
		json.append("\"").append(bean.getSlide()).append("\",");

		json.setCharAt(json.length() - 1, '}');

		return json.toString();
	}

	public static String listToJson(List<ConfigPPTTemplateBean> list) {
		StringBuilder json = new StringBuilder();
		json.append("{\"MSG\":");
		if (list.size() == 1) {
			ConfigPPTTemplateBean errorBean = list.get(0);
			if (errorBean.isError) {
				json.append("\"" + errorBean.getErrorMessage() + "\"");
				json.append(",");
				json.append("\"STATUS\":\"NO\"");
				json.append("}");
				return json.toString();
			}
		}

		json.append("[");
		for (ConfigPPTTemplateBean bean : list) {
			json.append(beanToJson(bean));
			json.append(",");
		}
		json.setCharAt(json.length() - 1, ']');
		json.append(",");
		json.append("\"STATUS\":\"YES\"");
		json.append("}");
		return json.toString();
	}

	public boolean isEmptyObj() {
		String rowStr = this.request_id + this.sheet + this.range + this.hide_rows + this.hide_columns
				+ this.header_text + this.autofit_rows + this.autofit_columns + this.custom_column_width
				+ this.custom_row_height + this.wrap_text_rows + this.display_gridline + this.slide;
		if (rowStr == null || rowStr.trim().equals(""))
			return true;
		return false;
	}
}
