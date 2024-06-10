package com.example.curriculoapi.controller;

import com.example.curriculoapi.model.Curriculo;
import com.example.curriculoapi.service.CurriculoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/curriculos")
public class CurriculoController {

    private final CurriculoService curriculoService;

    @Autowired
    public CurriculoController(CurriculoService curriculoService) {
        this.curriculoService = curriculoService;
    }

    @GetMapping
    public List<Curriculo> listarCurriculos() {
        return curriculoService.listarCurriculos();
    }

    @PostMapping
    public Curriculo criarCurriculo(@RequestBody Curriculo curriculo) {
        return curriculoService.criarCurriculo(curriculo);
    }

    @PutMapping("/{id}")
    public Curriculo atualizarCurriculo(@PathVariable Long id, @RequestBody Curriculo curriculo) {
        return curriculoService.atualizarCurriculo(id, curriculo);
    }

    @DeleteMapping("/{id}")
    public void excluirCurriculo(@PathVariable Long id) {
        curriculoService.excluirCurriculo(id);
    }
}
