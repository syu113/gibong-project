package com.gibong.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gibong.web.model.Volun;


@Repository
public interface VolunDao 
{
	public List<Volun> volunList(Volun volun);
	
	public long volunListCount(Volun volun);
}
