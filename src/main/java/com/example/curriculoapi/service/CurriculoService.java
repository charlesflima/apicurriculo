package com.example.curriculoapi.service;

import com.example.curriculoapi.model.Curriculo;
import com.example.curriculoapi.repository.CurriculoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CurriculoService {

    @Autowired
    private CurriculoRepository curriculoRepository;

    public List<Curriculo> listarCurriculos() {
        return curriculoRepository.findAll();
    }

    public Curriculo criarCurriculo(Curriculo curriculo) {
        curriculo.setId(null); // Garante que o ID do currículo seja nulo para evitar atualização acidental
        return curriculoRepository.save(curriculo);
    }

    public Curriculo atualizarCurriculo(Long id, Curriculo curriculo) {
        Optional<Curriculo> curriculoOptional = curriculoRepository.findById(id);
        if (curriculoOptional.isPresent()) {
            Curriculo curriculoExistente = curriculoOptional.get();
            curriculoExistente.setNome(curriculo.getNome());
            curriculoExistente.setEmail(curriculo.getEmail());
            curriculoExistente.setTelefone(curriculo.getTelefone());
            curriculoExistente.setResumo(curriculo.getResumo());
            curriculoExistente.setExperiencia(curriculo.getExperiencia());
            curriculoExistente.setEducacao(curriculo.getEducacao());
            curriculoExistente.setHabilidades(curriculo.getHabilidades());
            return curriculoRepository.save(curriculoExistente);
        } else {
            throw new RuntimeException("Currículo não encontrado com o ID: " + id);
        }
    }

    public void excluirCurriculo(Long id) {
        if (curriculoRepository.existsById(id)) {
            curriculoRepository.deleteById(id);
        } else {
            throw new RuntimeException("Currículo não encontrado com o ID: " + id);
        }
    }
}
