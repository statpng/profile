import os
from pathlib import Path

# 파일 이름에서 보기 좋은 표시 이름 생성 (예: "my_report_final.pdf" -> "My Report Final")
def generate_display_name(filename):
    name = Path(filename).stem  # 확장자 제외한 파일 이름
    name = name.replace('_', ' ').replace('-', ' ') # 언더스코어, 하이픈을 공백으로
    return name.title() # 각 단어 첫 글자 대문자로

# 지정된 디렉토리의 파일들을 기반으로 HTML 리스트 아이템 생성
def create_html_list_items(directory="my_contents"): # 파일을 저장할 폴더 이름
    if not os.path.isdir(directory):
        return f"            <li>'{directory}' 폴더를 찾을 수 없습니다. 폴더를 생성해주세요.</li>"

    # HTML과 PDF 파일만 대상으로 함 (필요시 다른 확장자 추가)
    allowed_extensions = (".html", ".htm", ".pdf")
    files = sorted([f for f in os.listdir(directory) if f.lower().endswith(allowed_extensions)])

    if not files:
        return f"            <li>'{directory}' 폴더에 표시할 파일이 없습니다.</li>"

    html_items = []
    for f_name in files:
        display_name = generate_display_name(f_name)
        file_ext = Path(f_name).suffix[1:].upper()  # 'HTML' 또는 'PDF'
        
        # 링크 생성. 사용자의 단순화된 HTML 구조를 따름
        # (이전의 class="plot-link link-discrete" 등은 제외)
        html_items.append(
            f'            <li><a href="{directory}/{f_name}">{display_name}</a> <span class="file-type-tag">{file_ext}</span></li>'
        )
    return "\n".join(html_items)

def main():
    files_directory = "my_contents"  # HTML/PDF 파일들을 넣을 폴더 이름
    template_filepath = "index.html.template"
    output_filepath = "index.html"

    # 템플릿 파일 읽기
    try:
        with open(template_filepath, "r", encoding="utf-8") as f:
            template_content = f.read()
    except FileNotFoundError:
        print(f"알림: '{template_filepath}' 파일을 찾을 수 없습니다. 기본 템플릿을 생성합니다.")
        default_template_content = """<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>파일 목록</title>
    <style>
        body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif; margin: 30px; background-color: #f8f9fa; color: #212529; }
        .container { max-width: 700px; margin: 20px auto; background-color: #fff; padding: 25px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.07); }
        h1 { font-size: 1.8em; color: #343a40; margin-bottom: 20px; text-align: center; }
        ul { list-style-type: none; padding: 0; }
        li { margin-bottom: 12px; background-color: #fdfdfd; border: 1px solid #e9ecef; padding: 12px 15px; border-radius: 5px; transition: background-color 0.2s ease; }
        li:hover { background-color: #f1f3f5; }
        a { text-decoration: none; font-size: 1.1em; color: #007bff; font-weight: 500; }
        a:hover { text-decoration: underline; }
        .file-type-tag {
            font-size: 0.75em;
            background-color: #e9ecef;
            padding: 3px 7px;
            border-radius: 4px;
            margin-left: 10px;
            color: #495057;
            border: 1px solid #dee2e6;
            text-transform: uppercase;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>생성된 파일 목록</h1>
        <ul>
            </ul>
    </div>
</body>
</html>"""
        with open(template_filepath, "w", encoding="utf-8") as f_template:
            f_template.write(default_template_content)
        print(f"'{template_filepath}' 파일이 기본 내용으로 새로 생성되었습니다. 필요시 내용을 수정하세요.")
        template_content = default_template_content
    
    # HTML 리스트 아이템 생성
    list_items_html = create_html_list_items(files_directory)
    
    # 템플릿의 플레이스홀더를 생성된 리스트로 교체
    output_html_content = template_content.replace("", list_items_html)
    
    # 최종 index.html 파일 작성
    with open(output_filepath, "w", encoding="utf-8") as f:
        f.write(output_html_content)
        
    print(f"'{output_filepath}' 파일이 '{files_directory}' 폴더의 내용으로 성공적으로 업데이트되었습니다.")
    
    # 만약 'my_contents' 폴더가 없다면 사용자에게 안내
    if not os.path.isdir(files_directory):
         print(f"주의: '{files_directory}' 폴더가 아직 없습니다. 폴더를 만들고 그 안에 HTML/PDF 파일을 넣어주세요.")

if __name__ == "__main__":
    main()
