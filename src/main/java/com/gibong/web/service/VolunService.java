package com.gibong.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gibong.web.dao.VolunDao;
import com.gibong.web.model.Volun;

@Service("volunService")
public class VolunService 
{
	private static Logger logger = LoggerFactory.getLogger(VolunService.class);
	
	
	@Autowired
	private VolunDao volunDao;
	
	
	public List<Volun> volunList(Volun volun)
	{
		List<Volun> list = null;
		
		try
		{
			list = volunDao.volunList(volun);
		}
		catch(Exception e)
		{
			logger.error("[VolunService] volunList Exception", e);
		}
		
		return list;
	}
	
	public long volunListCount(Volun volun)
	{
		long count = 0;
		
		try
		{
			count = volunDao.volunListCount(volun);
		}
		catch(Exception e)
		{
			logger.error("[VolunService] volunListCount Exception", e);
		}
		
		return count;
	}
}
