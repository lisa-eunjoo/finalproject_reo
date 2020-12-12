package kr.co.reo.admin.office.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.HashMap;
import java.util.List;

import javax.imageio.ImageIO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

import kr.co.reo.admin.office.dao.AdminOfficeDAO;
import kr.co.reo.common.dto.MemberDTO;
import kr.co.reo.common.dto.OffImgsDTO;
import kr.co.reo.common.dto.OffOptDTO;
import kr.co.reo.common.dto.OfficeDTO;
import kr.co.reo.common.util.PageUtil;

@Service("adminOfficeService")
public class AdminOfficeServiceImpl implements AdminOfficeService {
	@Autowired
	private AdminOfficeDAO adminOfficeDAO;

	@Autowired
	private PageUtil pageUtil;

	@Override
	public List<OfficeDTO> getOfficeList(OfficeDTO offDTO) {
		int totalRows = getOfficeListCount();
		offDTO.setPageNo(pageUtil.ablePageNo(offDTO.getPageNo(), totalRows));

		offDTO.setLIMIT(pageUtil.getLimit());
		offDTO.setOFFSET(pageUtil.getOffset(offDTO.getPageNo()));

		return adminOfficeDAO.getOfficeList(offDTO);
	}

	@Override
	public int getOfficeListCount() {
		return adminOfficeDAO.getOfficeListCount();
	}

	@Override
	public List<OfficeDTO> getOfficeSortedList(HashMap<String, Object> order) {
		return adminOfficeDAO.getOfficeSortedList(order);
	}

	@Override
	public List<OfficeDTO> getOfficeListByUnit(HashMap<String, Object> filterMap) {
		int totalRows = getOffFilterListCount(filterMap);
//		offDTO.setPageNo(pageUtil.ablePageNo(offDTO.getPageNo(), totalRows));
//		
//		offDTO.setLIMIT(pageUtil.getLimit());
//		offDTO.setOFFSET(pageUtil.getOffset(offDTO.getPageNo()));
		filterMap.put("pageNo", pageUtil.ablePageNo(Integer.parseInt(filterMap.get("pageNo").toString()), totalRows));
		filterMap.put("LIMIT", pageUtil.getLimit());
		filterMap.put("OFFSET", pageUtil.getOffset(Integer.parseInt(filterMap.get("pageNo").toString())));

		return adminOfficeDAO.getOfficeListByUnit(filterMap);
	}

	@Override
	public int getOffFilterListCount(HashMap<String, Object> unit) {
		return adminOfficeDAO.getOffFilterListCount(unit);
	}

	@Override
	public OfficeDTO getOffice(OfficeDTO dto) {
		return adminOfficeDAO.getOffice(dto);
	}

	@Override
	public List<OfficeDTO> getOfficeByemail(OfficeDTO dto) {
		return adminOfficeDAO.getOfficeByemail(dto);
	}

	@Override
	public MemberDTO getAgentNameTel(OfficeDTO dto) {
		return adminOfficeDAO.getAgentNameTel(dto);
	}

	@Override
	public void insertOffice(OfficeDTO dto) {
		adminOfficeDAO.insertOffice(dto);
	}

	@Override
	public void insertOffimgs(OffImgsDTO dto) {
		adminOfficeDAO.insertOffimgs(dto);
	}

	@Override
	public void insertOffopt(OffOptDTO dto) {
		adminOfficeDAO.insertOffopt(dto);
	}

	@Override
	public int getLatestOffno(OfficeDTO dto) {
		return adminOfficeDAO.getLatestOffno(dto);
	}

	@Override
	public List<OffImgsDTO> getOffimgs(OfficeDTO dto) {
		return adminOfficeDAO.getOffimgs(dto);
	}

	@Override
	public List<OffOptDTO> getOffopts(OfficeDTO dto) {
		return adminOfficeDAO.getOffopts(dto);
	}

	@Override
	public OffImgsDTO getOffimgOne(OfficeDTO dto) {
		return adminOfficeDAO.getOffimgOne(dto);
	}

	@Override
	public int deleteOffimgs(OffImgsDTO dto) {
		return adminOfficeDAO.deleteOffimgs(dto);
	}

	@Override
	public int deleteOffopts(OffOptDTO dto) {
		return adminOfficeDAO.deleteOffopts(dto);
	}

	@Override
	public void updateOffice(OfficeDTO dto) {
		adminOfficeDAO.updateOffice(dto);
	}

	@Override
	public int deleteOffice(OfficeDTO dto) {
		return adminOfficeDAO.deleteOffice(dto);
	}

	@Override
	public int getSearchWish(HashMap<String, Object> wishmap) {
		return adminOfficeDAO.getSearchWish(wishmap);
	}

	@Override
	public int insertWish(HashMap<String, Object> wishmap) {
		return adminOfficeDAO.insertWish(wishmap);
	}

	@Override
	public int deleteWish(HashMap<String, Object> wishmap) {
		return adminOfficeDAO.deleteWish(wishmap);
	}

	public boolean createQRCode(String filePath, String path, int off_no) {
		int size = 175;
		try {
//			File file = new File(filePath);
//			if (!file.exists()) {
//				file.mkdirs();
//			}
			String fileName = "REO_QR" + off_no + ".png";
			String qrURL = path + "/android/getOfiice?off_no=" + off_no;
			qrURL = new String(qrURL.getBytes("UTF-8"), "ISO-8859-1");
			int qrColor = 0xFF222222; // QR코드 색상
			int qrBackColor = 0xFFFFFFFF; // QR코드 색상
			QRCodeWriter writer = new QRCodeWriter();
			BitMatrix matrix = writer.encode(qrURL, BarcodeFormat.QR_CODE, size, size);
			MatrixToImageConfig config = new MatrixToImageConfig(qrColor, qrBackColor);
			BufferedImage qrImage = MatrixToImageWriter.toBufferedImage(matrix, config);
			ImageIO.write(qrImage, "png", new File(filePath + fileName));
		} catch (Exception e) {
			System.out.println("CreateQRCode : " + e);
			return false;
		}
		return true;
	}
}