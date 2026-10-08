"""生成隔离的中文 Office 样例；可选实际 PDF 渲染及逐页 PNG 检查。"""
import argparse
from pathlib import Path
import shutil
import subprocess
import tempfile

import studio


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--require-render', action='store_true')
    args = parser.parse_args()
    if studio.doctor(args.require_render):
        return 1
    work = studio.ROOT / 'work'
    work.mkdir(exist_ok=True)
    target = Path(tempfile.mkdtemp(prefix='smoke-', dir=work))
    source = target / 'sample.md'
    source.write_text('# 中文创作工作室\n\n安装与启动验证。保留原稿，分镜画面待补。\n', encoding='utf-8')
    studio.export_docx(source, target / 'sample.docx')
    studio.export_pptx(studio.ROOT / 'templates/storyboard.json', target / 'storyboard.pptx')
    if args.require_render:
        from pypdf import PdfReader
        office = shutil.which('libreoffice') or shutil.which('soffice')
        profile = (target / 'office-profile').resolve().as_uri()
        shot_count = len(studio.load_storyboard(studio.ROOT / 'templates/storyboard.json')['shots'])
        for filename, pages, expected in (('sample.docx', 1, '中文创作工作室'),
                                          ('storyboard.pptx', shot_count, '画面待补')):
            subprocess.run([office, f'-env:UserInstallation={profile}', '--headless', '--convert-to',
                            'pdf', '--outdir', str(target), str(target / filename)], check=True, timeout=120)
            pdf = target / Path(filename).with_suffix('.pdf')
            reader = PdfReader(pdf)
            assert len(reader.pages) == pages, f'{filename} 页数异常'
            content = ''.join(p.extract_text() for p in reader.pages).replace(' ', '').replace('\n', '')
            assert expected in content, f'{filename} 中文文本提取失败，请检查字体'
            subprocess.run(['pdftoppm', '-scale-to', '1400', '-png', str(pdf),
                            str(target / pdf.stem)], check=True, timeout=120)
        print('PDF 中文与页数检查通过；正式交付前仍需逐页查看 PNG。')
    print(f'验证样例：{target}')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
