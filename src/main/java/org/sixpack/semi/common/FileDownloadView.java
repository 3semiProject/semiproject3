package org.sixpack.semi.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;

@Component("filedown")
public class FileDownloadView extends AbstractView{

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		File renameFile = (File)model.get("renameFile");
		File originFile = (File)model.get("originFile");
		
		String fileName = originFile.getName();
		response.setContentType("text/plain; charset=utf-8");
		response.addHeader("Content-Disposition", "attachment; filename=\""
				+ new String(fileName.getBytes("UTF-8"), "ISO-8859-1") + "\"");
		FileInputStream fin = new FileInputStream(renameFile);
		OutputStream out = response.getOutputStream();
		FileCopyUtils.copy(fin, out);
		fin.close();
	}

}
