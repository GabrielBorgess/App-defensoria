import 'package:flutter/material.dart';

Widget dialogBox(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.height * 0.40,
      height: MediaQuery.of(context).size.height * 0.70,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.00   
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 18,
                        top: 14,
                        right: 18,
                      ),
                      child: Text(
                        "Termos de Serviços\n & \nPolítica de Privacidade",
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 10,
                      ),
                      child: Text(
                        """====================

Última Atualização: 22 de Novembro, 2023

Por favor, leia os termos e as condições com atenção antes de usar nosso serviço.

Aviso de privacidade e proteção de dados pessoais
A Defensoria Pública do Distrito Federal - DPDF, em observância à Lei nº 13.709, de 14 de agosto de 2018 (Lei Geral de Proteção de Dados Pessoais – LGPD), e ao Decreto nº 42.036/2021, de 27 de abril de 2021, instituiu o Aviso de Privacidade e de Proteção de Dados Pessoais, instrumento basilar para a implementação do Programa de Privacidade e Proteção de Dados Pessoais desta DPDF a ser elaborado em consonância com a missão, a visão e os valores institucionais. O Aviso e as ações previstas no supracitado Programa fundamentam-se no art. 5º da LGPD, bem como nos conceitos e regramentos previstos nas normas voltadas à segurança da informação, à governança, à gestão de riscos e à gestão documental, entre outras afins.

    • Princípios
São princípios do Aviso de Privacidade e de Proteção de Dados Pessoais da DPDF:
    1. Resiliência: os controles de segurança devem ser projetados para que possam resistir ou se recuperar dos efeitos de um incidente ou desastre;
    2. Simplicidade: os controles de segurança deverão ser simples e objetivos, visto que a complexidade aumenta a chance de equívocos;
    3. Clareza: as informações precisam ser claras e objetivas para que possam ser aplicadas efetivamente em todos os níveis da SEEDF;
    4. Confidencialidade;
    5. Integridade;
    6. Autenticidade, e
    7. Disponibilidade das informações.

    • Objetivos
São objetivos que visam à privacidade e à proteção de dados pessoais na DPDF:
    1. Proteger as informações coletadas e tratadas pela DPDF, de forma a garantir a confidencialidade, a autenticidade e a integridade;
    2. Promover e desenvolver a cultura da segurança dos dados pessoais em todos os níveis da instituição;
    3. Possibilitar a criação de controles e promover a otimização dos recursos de tecnologia da informação e documentação;
    4. Especificar a forma pela qual os dados dos titulares são coletados e tratados;
    5. Explicitar os direitos dos titulares a fim de garantir a transparência dos procedimentos adotados no tratamento de dados pessoais neste Ente.

    • Legislação correlata
O Aviso de Privacidade e de Proteção de Dados Pessoais da DPDF baseia-se na seguinte legislação:
    1. Lei nº 13.709/2018 - Lei Geral de Proteção de Dados Pessoais/ LGPD, que dispõe sobre o tratamento de dados pessoais, inclusive nos meios digitais, por pessoa natural ou por pessoa jurídica de direito público ou privado, com o objetivo de proteger os direitos fundamentais de liberdade e de privacidade e o livre desenvolvimento da personalidade da pessoa natural;
    2. Decreto nº 42.036/2021 - dispõe sobre a aplicação da Lei Federal nº 13.709, de 14 de agosto de 2018 - Lei Geral de Proteção de Dados Pessoais - LGPD, no âmbito da Administração Pública Direta e Indireta do Distrito Federal;
    3. Lei Federal nº 12.527/2011 - Lei de Acesso à Informação, que regula o acesso a informações previsto no inciso XXXIII do art. 5º, no inciso II do § 3º do art. 37 e no § 2º do art. 216 da Constituição Federal;
    4. Lei nº 4.990/2012, que regula o acesso a informações no Distrito Federal previsto no art. 5º, XXXIII, no art. 37, § 3º, II, e no art. 216, §2º da Constituição Federal e nos termos do art. 45, da Lei Federal nº 12.527/2011,
    5. Normas ABNT NBR ISO/IEC 27001:2013, 27002:2013, 27005:2011 e 31000:2018;
    6. Normas vigentes na Administração Pública do Distrito Federal relacionadas à governança, à gestão de riscos, à gestão documental e à segurança da informação.

    • Direitos dos titulares de dados pessoais
São direitos dos titulares de dados pessoais:
    1. confirmação da existência de tratamento;
    2. acesso aos seus dados;
    3. correção de dados incompletos, inexatos ou desatualizados;
    4. anonimização, bloqueio ou eliminação de dados desnecessários, excessivos ou tratados em desconformidade com o disposto na LGPD;
    5. portabilidade dos dados a outro fornecedor de serviço ou produto, mediante requisição expressa, de acordo com a regulamentação da autoridade nacional, observados os segredos comercial e industrial;
    6. eliminação dos dados pessoais tratados com o consentimento do titular, exceto nas hipóteses previstas no art. 16 da LGPD;
    7. informação das entidades públicas e privadas com as quais o controlador realizou uso compartilhado de dados;
    8. informação sobre a possibilidade de não fornecer consentimento e sobre as consequências da negativa;
    9. revogação do consentimento, nos termos do § 5º do art. 8º da LGPD.

    • Coleta de dados pessoais
Os dados pessoais dos titulares e, quando for o caso, de seus responsáveis são coletados a partir de cadastros específicos nas diversas ferramentas e nos sistemas em uso na DPDF.  Tais cadastros possuem objetivos próprios de tratamento de dados para, entre outros fins, cumprimento de obrigação legal ou regulatória pelo controlador, execução de políticas públicas e de contratos administrativos.
A DPDF é responsável por aplicar as medidas técnicas, de segurança tecnológica e de processos para assegurar a devida proteção dos dados coletados, tratados ou compartilhados.
    • Compartilhamento de dados pessoais
Os dados pessoais poderão ser compartilhados com os operadores contratados pela DPDF, o Ministério Público, as autoridades judiciais, administrativas ou governamentais competentes, os órgãos de controle e fiscalização, além de outras hipóteses previstas na LGPD, sempre que houver determinação legal, requisição ou ordem judicial.
    • Revisão do Aviso de Privacidade e de Proteção de Dados Pessoais da DPDF
A revisão deste Aviso de Privacidade e de Proteção de Dados Pessoais deve ser realizada em ciclos não superiores a 1 (um) ano e abranger os processos de trabalho das áreas técnicas da DPDF.
    • Utilização de cookies
Os cookies utilizados sítio eletrônico e nos aplicativos em uso pela DPDF são cookies estritamente necessários, como os de funcionalidade e segurança.
""",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
